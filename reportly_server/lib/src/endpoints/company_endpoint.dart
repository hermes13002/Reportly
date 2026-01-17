import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for company crud operations
class CompanyEndpoint extends Endpoint {
  /// create a new company
  Future<Company> create(Session session, Company company) async {
    company.createdAt = DateTime.now();
    company.updatedAt = DateTime.now();
    return await Company.db.insertRow(session, company);
  }

  /// get all companies
  Future<List<Company>> list(Session session) async {
    return await Company.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  /// get company by id
  Future<Company?> getById(Session session, int id) async {
    return await Company.db.findById(session, id);
  }

  /// update company
  Future<Company> update(Session session, Company company) async {
    company.updatedAt = DateTime.now();
    return await Company.db.updateRow(session, company);
  }

  /// delete company by id
  Future<bool> delete(Session session, int id) async {
    final deleted = await Company.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
