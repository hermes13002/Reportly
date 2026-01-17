import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for report crud operations
class ReportEndpoint extends Endpoint {
  /// create a new report (draft status)
  Future<Report> create(Session session, Report report) async {
    report.status = 'draft';
    report.createdAt = DateTime.now();
    report.updatedAt = DateTime.now();
    return await Report.db.insertRow(session, report);
  }

  /// get reports by company id
  Future<List<Report>> listByCompany(
    Session session,
    int companyId, {
    String? status,
    int limit = 20,
    int offset = 0,
  }) async {
    var whereClause = Report.t.companyId.equals(companyId);
    if (status != null) {
      whereClause = whereClause & Report.t.status.equals(status);
    }

    return await Report.db.find(
      session,
      where: (t) => whereClause,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// get report by id
  Future<Report?> getById(Session session, int id) async {
    return await Report.db.findById(session, id);
  }

  /// update report content (only drafts)
  Future<Report> update(Session session, Report report) async {
    if (report.status != 'draft') {
      throw Exception('Cannot update sent reports');
    }
    report.updatedAt = DateTime.now();
    return await Report.db.updateRow(session, report);
  }

  /// mark report as sent
  Future<Report> markSent(
    Session session,
    int id,
    String deliveryChannel,
  ) async {
    final report = await Report.db.findById(session, id);
    if (report == null) throw Exception('Report not found');
    if (report.status == 'sent') throw Exception('Report already sent');

    report.status = 'sent';
    report.sentAt = DateTime.now();
    report.deliveryChannel = deliveryChannel;
    report.updatedAt = DateTime.now();
    return await Report.db.updateRow(session, report);
  }

  /// archive a report
  Future<Report> archive(Session session, int id) async {
    final report = await Report.db.findById(session, id);
    if (report == null) throw Exception('Report not found');

    report.status = 'archived';
    report.updatedAt = DateTime.now();
    return await Report.db.updateRow(session, report);
  }

  /// delete report by id (only drafts)
  Future<bool> delete(Session session, int id) async {
    final report = await Report.db.findById(session, id);
    if (report == null) return false;
    if (report.status != 'draft') {
      throw Exception('Cannot delete sent or archived reports');
    }

    final deleted = await Report.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
