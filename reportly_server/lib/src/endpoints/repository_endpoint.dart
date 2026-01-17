import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for repository crud operations
class RepositoryEndpoint extends Endpoint {
  /// create a new repository
  Future<Repository> create(Session session, Repository repository) async {
    repository.createdAt = DateTime.now();
    repository.updatedAt = DateTime.now();
    return await Repository.db.insertRow(session, repository);
  }

  /// get repositories by company id
  Future<List<Repository>> listByCompany(Session session, int companyId) async {
    return await Repository.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.repoName,
    );
  }

  /// get repository by id
  Future<Repository?> getById(Session session, int id) async {
    return await Repository.db.findById(session, id);
  }

  /// update repository
  Future<Repository> update(Session session, Repository repository) async {
    repository.updatedAt = DateTime.now();
    return await Repository.db.updateRow(session, repository);
  }

  /// delete repository by id
  Future<bool> delete(Session session, int id) async {
    final deleted = await Repository.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }

  /// toggle repository active status
  Future<Repository> toggleActive(Session session, int id) async {
    final repo = await Repository.db.findById(session, id);
    if (repo == null) throw Exception('Repository not found');
    
    repo.isActive = !repo.isActive;
    repo.updatedAt = DateTime.now();
    return await Repository.db.updateRow(session, repo);
  }
}
