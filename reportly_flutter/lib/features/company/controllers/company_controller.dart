import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// controller for company-related state
class CompanyController extends GetxController {
  final companies = <Company>[].obs;
  final filteredCompanies = <Company>[].obs;
  final searchQuery = ''.obs;
  final stats = <String, dynamic>{
    'activeRepos': 0,
    'pendingReports': 0,
  }.obs;

  final isLoading = true.obs;
  final error = RxnString();
  final selectedCompany = Rxn<Company>();

  @override
  void onInit() {
    super.onInit();
    dev.log('CompanyController initialized', name: 'CompanyController');
    loadCompanies();
  }

  Future<void> loadCompanies() async {
    try {
      isLoading.value = true;
      error.value = null;
      dev.log('Loading companies...', name: 'CompanyController');

      final result = await client.company.list();

      dev.log('Loaded ${result.length} companies', name: 'CompanyController');
      companies.value = result;
      _updateFilteredList();
      loadDashboardStats(); // Load stats after companies are loaded
    } catch (e, stackTrace) {
      dev.log(
        'Error loading companies: $e',
        name: 'CompanyController',
        error: e,
        stackTrace: stackTrace,
      );
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectCompany(Company company) {
    dev.log('Selected company: ${company.name}', name: 'CompanyController');
    selectedCompany.value = company;
  }

  Future<Company> createCompany(Company company) async {
    dev.log(
      'Creating company: ${company.name}',
      name: 'CompanyController',
    );
    dev.log(
      'Company data: name=${company.name}, timezone=${company.timezone}, frequency=${company.reportFrequency}',
      name: 'CompanyController',
    );

    try {
      final saved = await client.company.create(company);
      dev.log(
        'Company created successfully: id=${saved.id}, name=${saved.name}',
        name: 'CompanyController',
      );
      companies.add(saved);
      return saved;
    } catch (e, stackTrace) {
      dev.log(
        'Error creating company: $e',
        name: 'CompanyController',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Company> updateCompany(Company company) async {
    dev.log(
      'Updating company: id=${company.id}, name=${company.name}',
      name: 'CompanyController',
    );

    try {
      final saved = await client.company.update(company);
      dev.log(
        'Company updated successfully: id=${saved.id}',
        name: 'CompanyController',
      );
      final index = companies.indexWhere((c) => c.id == saved.id);
      if (index != -1) {
        companies[index] = saved;
      }
      return saved;
    } catch (e, stackTrace) {
      dev.log(
        'Error updating company: $e',
        name: 'CompanyController',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> deleteCompany(int id) async {
    dev.log('Deleting company: id=$id', name: 'CompanyController');

    try {
      await client.company.delete(id);
      dev.log(
        'Company deleted successfully: id=$id',
        name: 'CompanyController',
      );
      companies.removeWhere((c) => c.id == id);
    } catch (e, stackTrace) {
      dev.log(
        'Error deleting company: $e',
        name: 'CompanyController',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  void searchCompanies(String query) {
    searchQuery.value = query;
    _updateFilteredList();
  }

  void _updateFilteredList() {
    if (searchQuery.value.isEmpty) {
      filteredCompanies.value = companies;
    } else {
      filteredCompanies.value = companies
          .where(
            (c) =>
                c.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
          )
          .toList();
    }
  }

  Future<void> loadDashboardStats() async {
    try {
      // 1. Active Repos
      // Fetch for all companies parallel
      final repoFutures = companies.map(
        (c) => client.repository.listByCompany(c.id!),
      );
      final allRepos = await Future.wait(repoFutures);
      final activeCount = allRepos
          .expand((list) => list)
          .where((r) => r.isActive)
          .length;

      // 2. Pending Reports (Drafts)
      final reportFutures = companies.map(
        (c) => client.report.listByCompany(
          c.id!,
          status: 'draft',
          limit: 100,
          offset: 0,
        ),
      ); // check limit
      final allReports = await Future.wait(reportFutures);
      final draftCount = allReports.expand((list) => list).length;

      stats.value = {
        'activeRepos': activeCount,
        'pendingReports': draftCount,
      };
    } catch (e) {
      dev.log('Error loading dashboard stats: $e', name: 'CompanyController');
      // keep default 0
    }
  }
}
