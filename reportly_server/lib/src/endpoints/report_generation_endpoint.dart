import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/github_service.dart';
import '../services/groq_service.dart';
import '../services/commit_processor.dart';
import '../services/template_engine.dart';
import '../services/delivery_service.dart';

/// endpoint for report generation and delivery
class ReportGenerationEndpoint extends Endpoint {
  /// generate a new report for a company
  Future<Report> generate(
    Session session, {
    required int companyId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // fetch company
    final company = await Company.db.findById(session, companyId);
    if (company == null) throw Exception('Company not found');

    // fetch repositories
    final repositories = await Repository.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.isActive.equals(true),
    );

    if (repositories.isEmpty) {
      throw Exception('No active repositories configured');
    }

    // initialize services
    final githubToken = session.passwords['githubToken'];
    if (githubToken == null) throw Exception('GitHub token not configured');

    final github = GitHubService(token: githubToken);
    final processor = CommitProcessor();

    // fetch commits from all repositories
    final allCommits = <GitHubCommit>[];
    for (final repo in repositories) {
      final parts = repo.repoName.split('/');
      if (parts.length != 2) continue;

      final excludePatterns = repo.excludePatterns
          ?.split(',')
          .map((e) => e.trim())
          .toList();

      try {
        final commits = await github.fetchCommits(
          owner: parts[0],
          repo: parts[1],
          branch: repo.branch,
          since: startDate,
          until: endDate,
          excludeAuthors: excludePatterns,
        );
        allCommits.addAll(commits);
      } catch (e) {
        session.log('Failed to fetch commits from ${repo.repoName}: $e');
      }
    }

    // group and process commits
    final customTypes = repositories.first.prefixRules
        ?.split(',')
        .map((e) => e.trim())
        .toList();
    final grouped = processor.groupByType(allCommits, customTypes: customTypes);

    // deduplicate each group
    final deduped = <String, List<String>>{};
    for (final entry in grouped.entries) {
      deduped[entry.key] = processor.deduplicate(entry.value);
    }

    // optional ai summarization
    String? aiSummary;
    if (company.aiEnabled) {
      final groqKey = session.passwords['groqApiKey'];
      if (groqKey != null) {
        try {
          final groq = GroqService(apiKey: groqKey);
          aiSummary = await groq.summarizeCommits(
            commits: processor.flatten(deduped),
            tone: company.toneSetting,
          );
          groq.dispose();
        } catch (e) {
          session.log('AI summarization failed: $e');
        }
      }
    }

    // get template
    final templates = await ReportTemplate.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.isDefault.equals(true),
      limit: 1,
    );

    final templateContent = templates.isNotEmpty
        ? templates.first.content
        : TemplateEngine.defaultTemplate;

    // process template
    final engine = TemplateEngine();
    final values = engine.buildValues(
      companyName: company.name,
      startDate: startDate,
      endDate: endDate,
      groupedCommits: deduped,
      summary: aiSummary,
    );
    final content = engine.process(templateContent, values);

    // create report
    final report = Report(
      companyId: companyId,
      startDate: startDate,
      endDate: endDate,
      content: content,
      rawCommitsJson: jsonEncode(deduped),
      aiSummary: aiSummary,
      status: 'draft',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    github.dispose();
    return await Report.db.insertRow(session, report);
  }

  /// regenerate an existing report
  Future<Report> regenerate(Session session, int reportId) async {
    final existing = await Report.db.findById(session, reportId);
    if (existing == null) throw Exception('Report not found');
    if (existing.status != 'draft')
      throw Exception('Cannot regenerate sent reports');

    final newReport = await generate(
      session,
      companyId: existing.companyId,
      startDate: existing.startDate,
      endDate: existing.endDate,
    );

    // delete old report
    await Report.db.deleteWhere(
      session,
      where: (t) => t.id.equals(reportId),
    );

    return newReport;
  }

  /// send report via default delivery channel
  Future<Report> send(Session session, int reportId) async {
    final report = await Report.db.findById(session, reportId);
    if (report == null) throw Exception('Report not found');
    if (report.status == 'sent') throw Exception('Report already sent');

    // get default channel
    final channels = await DeliveryChannel.db.find(
      session,
      where: (t) =>
          t.companyId.equals(report.companyId) & t.isDefault.equals(true),
      limit: 1,
    );

    if (channels.isEmpty) {
      throw Exception('No default delivery channel configured');
    }

    final channel = channels.first;
    await _deliverReport(session, report, channel);

    // update report status
    report.status = 'sent';
    report.sentAt = DateTime.now();
    report.deliveryChannel = channel.channelType;
    report.updatedAt = DateTime.now();

    return await Report.db.updateRow(session, report);
  }

  /// send report via specific channel
  Future<Report> sendViaChannel(
    Session session,
    int reportId,
    int channelId,
  ) async {
    final report = await Report.db.findById(session, reportId);
    if (report == null) throw Exception('Report not found');
    if (report.status == 'sent') throw Exception('Report already sent');

    final channel = await DeliveryChannel.db.findById(session, channelId);
    if (channel == null) throw Exception('Delivery channel not found');

    await _deliverReport(session, report, channel);

    report.status = 'sent';
    report.sentAt = DateTime.now();
    report.deliveryChannel = channel.channelType;
    report.updatedAt = DateTime.now();

    return await Report.db.updateRow(session, report);
  }

  Future<void> _deliverReport(
    Session session,
    Report report,
    DeliveryChannel channel,
  ) async {
    final config = jsonDecode(channel.configJson) as Map<String, dynamic>;

    switch (channel.channelType) {
      case 'email':
        final smtpHost = session.passwords['smtpHost'];
        final smtpPort = session.passwords['smtpPort'];
        final smtpUser = session.passwords['smtpUser'];
        final smtpPassword = session.passwords['smtpPassword'];
        final smtpFromName = session.passwords['smtpFromName'];
        final smtpFromEmail = session.passwords['smtpFromEmail'];

        if (smtpHost == null) throw Exception('SMTP not configured');

        final emailService = EmailDeliveryService(
          host: smtpHost,
          port: int.parse(smtpPort ?? '587'),
          username: smtpUser ?? '',
          password: smtpPassword ?? '',
          fromName: smtpFromName ?? 'Reportly',
          fromEmail: smtpFromEmail ?? '',
        );

        final recipients = (config['recipients'] as List<dynamic>)
            .cast<String>();
        final company = await Company.db.findById(session, report.companyId);

        await emailService.sendReport(
          recipients: recipients,
          subject: 'Weekly Report - ${company?.name ?? 'Unknown'}',
          content: report.content,
        );
        break;

      case 'clickup':
        // clickup delivery would be implemented here
        throw Exception('ClickUp delivery not yet implemented');

      case 'manual':
        // manual just marks as sent, no actual delivery
        break;

      default:
        throw Exception('Unknown channel type: ${channel.channelType}');
    }
  }
}
