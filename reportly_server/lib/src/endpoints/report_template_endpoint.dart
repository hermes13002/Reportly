import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for report template crud operations
class ReportTemplateEndpoint extends Endpoint {
  /// create a new template
  Future<ReportTemplate> create(
    Session session,
    ReportTemplate template,
  ) async {
    template.createdAt = DateTime.now();
    template.updatedAt = DateTime.now();
    template.version = 1;
    return await ReportTemplate.db.insertRow(session, template);
  }

  /// get templates by company id
  Future<List<ReportTemplate>> listByCompany(
    Session session,
    int companyId,
  ) async {
    return await ReportTemplate.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
    );
  }

  /// get default template for company
  Future<ReportTemplate?> getDefault(Session session, int companyId) async {
    final templates = await ReportTemplate.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.isDefault.equals(true),
      limit: 1,
    );
    return templates.isNotEmpty ? templates.first : null;
  }

  /// get template by id
  Future<ReportTemplate?> getById(Session session, int id) async {
    return await ReportTemplate.db.findById(session, id);
  }

  /// update template (increments version)
  Future<ReportTemplate> update(
    Session session,
    ReportTemplate template,
  ) async {
    template.updatedAt = DateTime.now();
    template.version = template.version + 1;
    return await ReportTemplate.db.updateRow(session, template);
  }

  /// set as default template for company
  Future<ReportTemplate> setDefault(Session session, int id) async {
    final template = await ReportTemplate.db.findById(session, id);
    if (template == null) throw Exception('Template not found');

    // unset current default
    final currentDefaults = await ReportTemplate.db.find(
      session,
      where: (t) =>
          t.companyId.equals(template.companyId) & t.isDefault.equals(true),
    );
    for (final t in currentDefaults) {
      t.isDefault = false;
      t.updatedAt = DateTime.now();
      await ReportTemplate.db.updateRow(session, t);
    }

    // set new default
    template.isDefault = true;
    template.updatedAt = DateTime.now();
    return await ReportTemplate.db.updateRow(session, template);
  }

  /// delete template by id
  Future<bool> delete(Session session, int id) async {
    final deleted = await ReportTemplate.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
