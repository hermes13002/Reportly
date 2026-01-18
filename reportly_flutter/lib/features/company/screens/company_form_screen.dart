import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import '../../../../core/constants/timezones.dart';

class CompanyFormScreen extends StatefulWidget {
  final Company? company;

  const CompanyFormScreen({super.key, this.company});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String _selectedTimezone = 'UTC';
  String _frequency = 'weekly';
  int? _customDays;
  String _tone = 'formal'; // Default to one of the UI options
  bool _saving = false;

  // Use common timezones
  // Use common timezones
  static final _timezones = TimezoneConstants.all;

  bool get _isEditing => widget.company != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.company?.name ?? '');

    // Map existing values or defaults
    _selectedTimezone = widget.company?.timezone ?? 'UTC';
    if (!_timezones.contains(_selectedTimezone)) {
      _selectedTimezone = 'UTC';
    }

    _frequency = widget.company?.reportFrequency ?? 'weekly';
    _customDays = widget.company?.customFrequencyDays;
    _tone =
        widget.company?.toneSetting ??
        'professional'; // professional/casual/technical

    // basic mapping for tone if old values exist
    if (_tone == 'neutral') _tone = 'professional';
    if (_tone == 'formal') _tone = 'professional';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Logo Placeholder
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F4B43), // Teal/Dark Green from mockup
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.business,
                        size: 40,
                        color: Colors.teal[100],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF8B5CF6), // Purple
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Change Logo',
                style: TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Company Name
            Text(
              'Company Name',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'Enter company name',
                fillColor: Theme.of(context).cardColor,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
              validator: (v) => v?.isNotEmpty == true ? null : 'Required',
            ),
            const SizedBox(height: 32),

            // Reporting Preferences Header
            Text(
              'Reporting Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 16),

            // Timezone
            Text(
              'Timezone',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _timezones.contains(_selectedTimezone)
                      ? _selectedTimezone
                      : _timezones.first,
                  isExpanded: true,
                  dropdownColor: Theme.of(context).cardColor,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  items: _timezones.map((tz) {
                    return DropdownMenuItem(
                      value: tz,
                      child: Text(
                        tz,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedTimezone = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Report Frequency
            Text(
              'Report Frequency',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildFrequencyOption('Daily'),
                      _buildFrequencyOption('Weekly'),
                      _buildFrequencyOption('Monthly'),
                      _buildFrequencyOption('Custom'),
                    ],
                  ),
                  if (_frequency == 'custom') ...[
                    Divider(height: 1, color: Theme.of(context).dividerColor),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            'Every',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              initialValue:
                                  _customDays?.toString() ??
                                  '10', // Default or logical value
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                fillColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                              onChanged: (v) {
                                setState(() {
                                  _customDays = int.tryParse(v);
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'days',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),

            // AI Tone
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AI Tone',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Preview',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Controls the personality of your automated reports.',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 16),

            _buildToneCard(
              id: 'professional',
              title: 'Professional',
              subtitle: 'Concise, formal, and objective.',
              icon: Icons.business_center,
            ),
            const SizedBox(height: 12),
            _buildToneCard(
              id: 'casual',
              title: 'Casual',
              subtitle: 'Friendly, conversational updates.',
              icon: Icons.coffee,
            ),
            const SizedBox(height: 12),
            _buildToneCard(
              id: 'technical',
              title: 'Technical',
              subtitle: 'Detailed, code-centric focus.',
              icon: Icons.terminal,
            ),

            const SizedBox(height: 48),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyOption(String label) {
    final lower = label.toLowerCase();
    final isSelected = _frequency == lower;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _frequency = lower),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToneCard({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _tone == id;
    final primary = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => setState(() => _tone = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? primary
                : Theme.of(context).dividerColor.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).scaffoldBackgroundColor, // Darker bg for icon
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? primary : Theme.of(context).iconTheme.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final company = Company(
        id: widget.company?.id,
        name: _nameController.text.trim(),
        description:
            widget.company?.description, // preserving old description if exists
        timezone: _selectedTimezone,
        reportFrequency: _frequency,
        customFrequencyDays: _frequency == 'custom' ? _customDays : null,
        aiEnabled: true, // Auto-enable AI for new tone logic
        toneSetting: _tone,
        createdAt: widget.company?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isEditing) {
        await client.company.update(company);
      } else {
        await client.company.create(company);
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to save: $e',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
