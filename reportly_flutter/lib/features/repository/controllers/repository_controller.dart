import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// controller for repository-related state
class RepositoryController extends GetxController {
  final repositories = <Repository>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  int? _currentCompanyId;

  Future<void> loadRepositories(int companyId) async {
    try {
      _currentCompanyId = companyId;
      isLoading.value = true;
      error.value = null;
      final result = await client.repository.listByCompany(companyId);
      repositories.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Repository> createRepository(Repository repository) async {
    final saved = await client.repository.create(repository);
    repositories.add(saved);
    return saved;
  }

  Future<Repository> updateRepository(Repository repository) async {
    final saved = await client.repository.update(repository);
    final index = repositories.indexWhere((r) => r.id == saved.id);
    if (index != -1) {
      repositories[index] = saved;
    }
    return saved;
  }

  Future<void> toggleActive(int id) async {
    final updated = await client.repository.toggleActive(id);
    final index = repositories.indexWhere((r) => r.id == id);
    if (index != -1) {
      repositories[index] = updated;
    }
  }

  Future<void> deleteRepository(int id) async {
    await client.repository.delete(id);
    repositories.removeWhere((r) => r.id == id);
  }

  void refresh() {
    if (_currentCompanyId != null) {
      loadRepositories(_currentCompanyId!);
    }
  }
}
