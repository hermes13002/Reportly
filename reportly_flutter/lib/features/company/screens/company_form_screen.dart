import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// add/edit company form
class CompanyFormScreen extends StatefulWidget {
  final Company? company;

  const CompanyFormScreen({super.key, this.company});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _timezoneController;
  late TextEditingController _templateNameController;
  late TextEditingController _templateContentController;

  String _frequency = 'weekly';
  int? _customDays;
  bool _aiEnabled = false;
  String _tone = 'neutral';
  bool _useCustomTemplate = false;
  bool _saving = false;

  bool get _isEditing => widget.company != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.company?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.company?.description ?? '',
    );
    _timezoneController = TextEditingController(
      text: widget.company?.timezone ?? 'UTC',
    );
    _templateNameController = TextEditingController(text: 'Weekly Report');
    _templateContentController = TextEditingController();

    if (_isEditing) {
      _frequency = widget.company!.reportFrequency;
      _customDays = widget.company!.customFrequencyDays;
      _aiEnabled = widget.company!.aiEnabled;
      _tone = widget.company!.toneSetting;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _timezoneController.dispose();
    _templateNameController.dispose();
    _templateContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Company' : 'Add Company'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                hintText: 'Enter company name',
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Brief description of the company',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // timezone
            TextFormField(
              controller: _timezoneController,
              decoration: const InputDecoration(
                labelText: 'Timezone',
                hintText: 'e.g., America/New_York',
                prefixIcon: Icon(Icons.schedule),
              ),
            ),
            const SizedBox(height: 24),

            // report frequency
            Text(
              'Report Frequency',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildFrequencyChip('weekly'),
                _buildFrequencyChip('bi-weekly'),
                _buildFrequencyChip('monthly'),
                _buildFrequencyChip('custom'),
              ],
            ),

            if (_frequency == 'custom') ...[
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _customDays?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Custom Days',
                  hintText: 'Number of days between reports',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _customDays = int.tryParse(value);
                },
              ),
            ],
            const SizedBox(height: 24),

            // ai settings
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'AI Summarization',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Switch(
                          value: _aiEnabled,
                          onChanged: (value) {
                            setState(() => _aiEnabled = value);
                          },
                        ),
                      ],
                    ),
                    if (_aiEnabled) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Tone',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'formal', label: Text('Formal')),
                          ButtonSegment(
                            value: 'neutral',
                            label: Text('Neutral'),
                          ),
                          ButtonSegment(value: 'casual', label: Text('Casual')),
                        ],
                        selected: {_tone},
                        onSelectionChanged: (selected) {
                          setState(() => _tone = selected.first);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // custom template (optional)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.article,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Report Template',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Switch(
                          value: _useCustomTemplate,
                          onChanged: (value) {
                            setState(() => _useCustomTemplate = value);
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Optional - create a custom template or use default',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    if (_useCustomTemplate) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _templateNameController,
                        decoration: const InputDecoration(
                          labelText: 'Template Name',
                          hintText: 'e.g., Weekly Update',
                          prefixIcon: Icon(Icons.label),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _templateContentController,
                        decoration: const InputDecoration(
                          labelText: 'Template Content',
                          hintText: 'Paste your template here...',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 8,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.orange.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  size: 16,
                                  color: Colors.orange[300],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Available Variables',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange[300],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '{{company_name}} - Company name\n'
                              '{{start_date}} / {{end_date}} - Report period\n'
                              '{{features}} - New features list\n'
                              '{{fixes}} - Bug fixes list\n'
                              '{{improvements}} - Refactors/improvements\n'
                              '{{notes}} - Your manual notes\n'
                              '{{summary}} - AI-generated summary',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[400],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // save button
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? 'Save Changes' : 'Create Company'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyChip(String freq) {
    final isSelected = _frequency == freq;
    return ChoiceChip(
      label: Text(freq),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _frequency = freq);
        }
      },
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      final company = Company(
        id: widget.company?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        timezone: _timezoneController.text.trim(),
        reportFrequency: _frequency,
        customFrequencyDays: _frequency == 'custom' ? _customDays : null,
        aiEnabled: _aiEnabled,
        toneSetting: _tone,
        createdAt: widget.company?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      Company savedCompany;
      if (_isEditing) {
        savedCompany = await client.company.update(company);
      } else {
        savedCompany = await client.company.create(company);
      }

      // create custom template if enabled and content provided
      if (!_isEditing &&
          _useCustomTemplate &&
          _templateContentController.text.trim().isNotEmpty) {
        final template = ReportTemplate(
          companyId: savedCompany.id!,
          name: _templateNameController.text.trim(),
          content: _templateContentController.text.trim(),
          isDefault: true,
          version: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await client.reportTemplate.create(template);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}
