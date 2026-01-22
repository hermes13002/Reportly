import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import 'package:collection/collection.dart';
import '../../../main.dart';
import 'report_preview_screen.dart';

/// report generation screen
class ReportGenerateScreen extends StatefulWidget {
  final Company company;

  const ReportGenerateScreen({super.key, required this.company});

  @override
  State<ReportGenerateScreen> createState() => _ReportGenerateScreenState();
}

class _ReportGenerateScreenState extends State<ReportGenerateScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  bool _generating = false;
  String? _error;
  List<ReportTemplate> _templates = [];
  int? _selectedTemplateId;
  bool _loadingTemplates = false;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() => _loadingTemplates = true);
    try {
      final templates = await client.reportTemplate.listByCompany(
        widget.company.id!,
      );
      if (mounted) {
        setState(() {
          _templates = templates;
          // select default if exists
          final def = templates.firstWhereOrNull((t) => t.isDefault)?.id;
          if (def != null) {
            _selectedTemplateId = def;
          } else if (templates.isNotEmpty) {
            _selectedTemplateId = templates.first.id;
          }
        });
      }
    } catch (e) {
      // silent fail for templates? or show snackbar
      print('Failed to load templates: $e');
    } finally {
      if (mounted) setState(() => _loadingTemplates = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // company info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          widget.company.name[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.company.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (widget.company.aiEnabled)
                            Text(
                              'AI summarization enabled',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.green,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // date range
            Text(
              'Report Period',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // start date
            _buildDatePicker(
              label: 'Start Date',
              date: _startDate,
              onPick: (date) => setState(() => _startDate = date),
            ),
            const SizedBox(height: 12),

            // end date
            _buildDatePicker(
              label: 'End Date',
              date: _endDate,
              onPick: (date) => setState(() => _endDate = date),
            ),
            const SizedBox(height: 24),

            // Template selection
            Text(
              'Template',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (_loadingTemplates)
              const Center(child: LinearProgressIndicator())
            else if (_templates.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedTemplateId,
                    isExpanded: true,
                    hint: const Text('Select a template'),
                    items: _templates.map((t) {
                      return DropdownMenuItem<int>(
                        value: t.id,
                        child: Text(t.name),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() => _selectedTemplateId = v);
                    },
                  ),
                ),
              )
            else
              const Text(
                'No templates found. Default template will be used.',
                style: TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 24),

            // quick select
            Text(
              'Quick Select',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickSelectChip('Last 7 days', 7),
                _buildQuickSelectChip('Last 14 days', 14),
                _buildQuickSelectChip('Last 30 days', 30),
                _buildQuickSelectChip('This month', -1),
              ],
            ),

            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            // generate button
            ElevatedButton.icon(
              onPressed: _generating ? null : _generate,
              icon: _generating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(_generating ? 'Generating...' : 'Generate Report'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime date,
    required Function(DateTime) onPick,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onPick(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSelectChip(String label, int days) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        final now = DateTime.now();
        if (days == -1) {
          // this month
          setState(() {
            _startDate = DateTime(now.year, now.month, 1);
            _endDate = now;
          });
        } else {
          setState(() {
            _startDate = now.subtract(Duration(days: days));
            _endDate = now;
          });
        }
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _generate() async {
    if (_startDate.isAfter(_endDate)) {
      setState(() => _error = 'Start date must be before end date');
      return;
    }

    setState(() {
      _generating = true;
      _error = null;
    });

    try {
      final report = await client.reportGeneration.generate(
        companyId: widget.company.id!,
        startDate: _startDate,
        endDate: _endDate,
        templateId: _selectedTemplateId,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReportPreviewScreen(
              company: widget.company,
              report: report,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _generating = false;
      });
    }
  }
}
