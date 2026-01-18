import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../controllers/template_controller.dart';
import 'template_form_screen.dart';

class TemplateListScreen extends StatefulWidget {
  final Company company;

  const TemplateListScreen({super.key, required this.company});

  @override
  State<TemplateListScreen> createState() => _TemplateListScreenState();
}

class _TemplateListScreenState extends State<TemplateListScreen> {
  TemplateController get controller => Get.find<TemplateController>();

  @override
  void initState() {
    super.initState();
    controller.loadTemplates(widget.company.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Templates'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${controller.error.value}'),
                TextButton(
                  onPressed: () => controller.loadTemplates(widget.company.id!),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.templates.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'No templates found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 8),
                Text(
                  'Create a template to standardize reports',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.templates.length,
          itemBuilder: (context, index) {
            final template = controller.templates[index];
            return _buildTemplateCard(template);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Get.to(() => TemplateFormScreen(company: widget.company)),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Create Template',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildTemplateCard(ReportTemplate template) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.description, color: Colors.blue),
        ),
        title: Row(
          children: [
            Text(template.name),
            if (template.isDefault) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'DEFAULT',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Get.to(
                () => TemplateFormScreen(
                  company: widget.company,
                  template: template,
                ),
              );
            } else if (value == 'default') {
              controller.setDefault(template);
            } else if (value == 'delete') {
              _deleteTemplate(template);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            if (!template.isDefault)
              const PopupMenuItem(
                value: 'default',
                child: Text('Set as Default'),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTemplate(ReportTemplate template) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Delete "${template.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await controller.deleteTemplate(template);
    }
  }
}
