import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../controllers/template_controller.dart';

class TemplateFormScreen extends StatefulWidget {
  final Company company;
  final ReportTemplate? template;

  const TemplateFormScreen({
    super.key,
    required this.company,
    this.template,
  });

  @override
  State<TemplateFormScreen> createState() => _TemplateFormScreenState();
}

class _TemplateFormScreenState extends State<TemplateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contentController;
  bool _isDefault = false;

  TemplateController get controller => Get.find<TemplateController>();
  bool get _isEditing => widget.template != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.template?.name ?? '');
    _contentController = TextEditingController(
      text: widget.template?.content ?? '',
    );
    _isDefault = widget.template?.isDefault ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Template' : 'Create Template'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Name
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Template Name',
                      hintText: 'e.g., Weekly Status Report',
                      prefixIcon: Icon(Icons.label),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Default Toggle
                  SwitchListTile(
                    title: const Text('Set as Default'),
                    subtitle: const Text('Use this template for new reports'),
                    value: _isDefault,
                    onChanged: (value) => setState(() => _isDefault = value),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Template Content',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton.icon(
                        onPressed: _showFormatGuide,
                        icon: const Icon(Icons.help_outline, size: 18),
                        label: const Text('Format Guide'),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Content Field
                  TextFormField(
                    controller: _contentController,
                    maxLines: 15,
                    style: const TextStyle(fontFamily: 'monospace'),
                    decoration: const InputDecoration(
                      hintText:
                          'Enter report template content (Markdown supported)...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1B2E),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            _isEditing ? 'Update Template' : 'Create Template',
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final template = ReportTemplate(
      id: widget.template?.id,
      companyId: widget.company.id!,
      name: _nameController.text.trim(),
      content: _contentController.text,
      isDefault: _isDefault,
      version: (widget.template?.version ?? 0) + 1,
      createdAt: widget.template?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      if (_isEditing) {
        await controller.updateTemplate(template);
      } else {
        await controller.createTemplate(template);
      }
      Get.back(result: true);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save template');
    }
  }

  void _showFormatGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Template Format Guide'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Reportly uses Markdown for formatting, seamlessly integrating with AI generation.',
              ),
              const SizedBox(height: 16),
              _buildGuideSection(context, 'Headers', '# Title\n## Section'),
              _buildGuideSection(context, 'Emphasis', '**Bold**\n*Italic*'),
              _buildGuideSection(context, 'Lists', '- Item 1\n- Item 2'),
              _buildGuideSection(
                context,
                'Placeholders',
                '{{company_name}}\n{{date_range}}\n{{ai_summary}}',
              ),
              const Divider(),
              const Text(
                'Example Template:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '# Weekly Report\n\n'
                  '**Company:** {{company_name}}\n'
                  '**Period:** {{date_range}}\n\n'
                  '## Summary\n'
                  '{{ai_summary}}\n\n'
                  '## Key Highlights\n'
                  '- Feature updates\n'
                  '- Bug fixes\n'
                  '- Next steps',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideSection(
    BuildContext context,
    String title,
    String example,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black26
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
            ),
            child: Text(
              example,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
