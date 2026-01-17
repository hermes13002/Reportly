import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for schedule config operations
class ScheduleConfigEndpoint extends Endpoint {
  /// create or update schedule config for company
  Future<ScheduleConfig> upsert(Session session, ScheduleConfig config) async {
    // check if config exists for company
    final existing = await ScheduleConfig.db.find(
      session,
      where: (t) => t.companyId.equals(config.companyId),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      config.id = existing.first.id;
      config.createdAt = existing.first.createdAt;
      config.updatedAt = DateTime.now();
      return await ScheduleConfig.db.updateRow(session, config);
    }

    config.createdAt = DateTime.now();
    config.updatedAt = DateTime.now();
    return await ScheduleConfig.db.insertRow(session, config);
  }

  /// get schedule config by company id
  Future<ScheduleConfig?> getByCompany(Session session, int companyId) async {
    final configs = await ScheduleConfig.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      limit: 1,
    );
    return configs.isNotEmpty ? configs.first : null;
  }

  /// toggle schedule enabled status
  Future<ScheduleConfig> toggleEnabled(Session session, int companyId) async {
    final config = await getByCompany(session, companyId);
    if (config == null) throw Exception('Schedule config not found');

    config.isEnabled = !config.isEnabled;
    config.updatedAt = DateTime.now();
    return await ScheduleConfig.db.updateRow(session, config);
  }

  /// update next run time
  Future<ScheduleConfig> updateNextRun(Session session, int companyId, DateTime nextRunAt) async {
    final config = await getByCompany(session, companyId);
    if (config == null) throw Exception('Schedule config not found');

    config.nextRunAt = nextRunAt;
    config.updatedAt = DateTime.now();
    return await ScheduleConfig.db.updateRow(session, config);
  }

  /// delete schedule config
  Future<bool> delete(Session session, int companyId) async {
    final deleted = await ScheduleConfig.db.deleteWhere(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    return deleted.isNotEmpty;
  }
}
