import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// controller for report-related state
class ReportController extends GetxController {
  final reports = <Report>[].obs;
  final isLoading = false.obs;
  final isGenerating = false.obs;
  final error = RxnString();
  final currentReport = Rxn<Report>();

  int? _currentCompanyId;

  Future<void> loadReports(int companyId, {String? status}) async {
    try {
      _currentCompanyId = companyId;
      isLoading.value = true;
      error.value = null;
      final result = await client.report.listByCompany(
        companyId,
        status: status,
        limit: 100,
        offset: 0,
      );
      reports.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Report> generateReport({
    required int companyId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      isGenerating.value = true;
      error.value = null;
      final report = await client.reportGeneration.generate(
        companyId: companyId,
        startDate: startDate,
        endDate: endDate,
      );
      reports.insert(0, report);
      currentReport.value = report;
      return report;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isGenerating.value = false;
    }
  }

  Future<Report> updateReport(Report report) async {
    final saved = await client.report.update(report);
    final index = reports.indexWhere((r) => r.id == saved.id);
    if (index != -1) {
      reports[index] = saved;
    }
    currentReport.value = saved;
    return saved;
  }

  Future<Report> sendReport(int reportId) async {
    final sent = await client.reportGeneration.send(reportId);
    final index = reports.indexWhere((r) => r.id == reportId);
    if (index != -1) {
      reports[index] = sent;
    }
    currentReport.value = sent;
    return sent;
  }

  void setCurrentReport(Report? report) {
    currentReport.value = report;
  }

  void refresh() {
    if (_currentCompanyId != null) {
      loadReports(_currentCompanyId!);
    }
  }
}
