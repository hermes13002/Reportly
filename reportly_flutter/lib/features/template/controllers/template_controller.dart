import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

class TemplateController extends GetxController {
  final templates = <ReportTemplate>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  Future<void> loadTemplates(int companyId) async {
    try {
      isLoading.value = true;
      error.value = null;
      final result = await client.reportTemplate.listByCompany(companyId);
      templates.value = result;
    } catch (e) {
      error.value = e.toString();
      dev.log('Error loading templates: $e', name: 'TemplateController');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTemplate(ReportTemplate template) async {
    try {
      isLoading.value = true;
      await client.reportTemplate.create(template);
      await loadTemplates(template.companyId);
    } catch (e) {
      error.value = e.toString();
      dev.log('Error creating template: $e', name: 'TemplateController');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTemplate(ReportTemplate template) async {
    try {
      isLoading.value = true;
      await client.reportTemplate.update(template);
      await loadTemplates(template.companyId);
    } catch (e) {
      error.value = e.toString();
      dev.log('Error updating template: $e', name: 'TemplateController');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTemplate(ReportTemplate template) async {
    try {
      isLoading.value = true;
      await client.reportTemplate.delete(template.id!);
      await loadTemplates(template.companyId);
    } catch (e) {
      error.value = e.toString();
      dev.log('Error deleting template: $e', name: 'TemplateController');
      rethrow; // Rethrow to handle in UI
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefault(ReportTemplate template) async {
    try {
      isLoading.value = true;
      await client.reportTemplate.setDefault(template.id!);
      await loadTemplates(template.companyId);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to set default: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
