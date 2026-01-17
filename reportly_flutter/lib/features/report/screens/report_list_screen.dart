import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'report_generate_screen.dart';
import 'report_preview_screen.dart';

/// report list for a company
class ReportListScreen extends StatefulWidget {
  final Company company;

  const ReportListScreen({super.key, required this.company});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Report>? _draftReports;
  List<Report>? _sentReports;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadReports();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadReports() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final drafts = await client.report.listByCompany(
        widget.company.id!,
        status: 'draft',
        limit: 50,
        offset: 0,
      );
      final sent = await client.report.listByCompany(
        widget.company.id!,
        status: 'sent',
        limit: 50,
        offset: 0,
      );
      setState(() {
        _draftReports = drafts;
        _sentReports = sent;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Drafts'),
            Tab(text: 'Sent'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReportList(_draftReports, isDraft: true),
          _buildReportList(_sentReports, isDraft: false),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToGenerate,
        icon: const Icon(Icons.add),
        label: const Text('Generate Report'),
      ),
    );
  }

  Widget _buildReportList(List<Report>? reports, {required bool isDraft}) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Error loading reports'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _loadReports,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (reports == null || reports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDraft ? Icons.edit_document : Icons.send,
              size: 80,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              isDraft ? 'No draft reports' : 'No sent reports',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (isDraft) ...[
              const SizedBox(height: 8),
              Text(
                'Generate a new report to get started',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadReports,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) =>
            _buildReportCard(reports[index], isDraft: isDraft),
      ),
    );
  }

  Widget _buildReportCard(Report report, {required bool isDraft}) {
    final dateRange =
        '${_formatDate(report.startDate)} - ${_formatDate(report.endDate)}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToPreview(report),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDraft
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isDraft ? Icons.edit : Icons.check_circle,
                  color: isDraft ? Colors.orange : Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateRange,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Created ${_formatDate(report.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    if (!isDraft && report.sentAt != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Sent via ${report.deliveryChannel ?? 'unknown'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _navigateToGenerate() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ReportGenerateScreen(company: widget.company),
      ),
    );
    if (result == true) {
      _loadReports();
    }
  }

  void _navigateToPreview(Report report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPreviewScreen(
          company: widget.company,
          report: report,
        ),
      ),
    ).then((_) => _loadReports());
  }
}
