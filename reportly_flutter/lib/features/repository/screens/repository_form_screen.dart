import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// add/edit repository form
class RepositoryFormScreen extends StatefulWidget {
  final Company company;
  final Repository? repository;

  const RepositoryFormScreen({
    super.key,
    required this.company,
    this.repository,
  });

  @override
  State<RepositoryFormScreen> createState() => _RepositoryFormScreenState();
}

class _RepositoryFormScreenState extends State<RepositoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _repoNameController;
  late TextEditingController _branchController;
  late TextEditingController _prefixRulesController;
  late TextEditingController _excludePatternsController;

  String _provider = 'github';
  bool _isActive = true;
  bool _saving = false;

  bool get _isEditing => widget.repository != null;

  @override
  void initState() {
    super.initState();
    _repoNameController = TextEditingController(
      text: widget.repository?.repoName ?? '',
    );
    _branchController = TextEditingController(
      text: widget.repository?.branch ?? 'main',
    );
    _prefixRulesController = TextEditingController(
      text: widget.repository?.prefixRules ?? 'feat,fix,refactor,docs',
    );
    _excludePatternsController = TextEditingController(
      text: widget.repository?.excludePatterns ?? '',
    );

    if (_isEditing) {
      _provider = widget.repository!.provider;
      _isActive = widget.repository!.isActive;
    }
  }

  @override
  void dispose() {
    _repoNameController.dispose();
    _branchController.dispose();
    _prefixRulesController.dispose();
    _excludePatternsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Repository' : 'Add Repository'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // provider
            Text(
              'Provider',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'github',
                  label: Text('GitHub'),
                  icon: Icon(Icons.code),
                ),
              ],
              selected: {_provider},
              onSelectionChanged: (selected) {
                setState(() => _provider = selected.first);
              },
            ),
            const SizedBox(height: 24),

            // repo name
            TextFormField(
              controller: _repoNameController,
              decoration: const InputDecoration(
                labelText: 'Repository Name',
                hintText: 'owner/repo-name',
                prefixIcon: Icon(Icons.source),
                helperText: 'Format: owner/repository-name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter repository name';
                }
                if (!value.contains('/')) {
                  return 'Use format: owner/repo-name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // branch
            TextFormField(
              controller: _branchController,
              decoration: const InputDecoration(
                labelText: 'Branch',
                hintText: 'main',
                prefixIcon: Icon(Icons.call_split),
              ),
            ),
            const SizedBox(height: 16),

            // prefix rules
            TextFormField(
              controller: _prefixRulesController,
              decoration: const InputDecoration(
                labelText: 'Commit Prefix Rules',
                hintText: 'feat,fix,refactor,docs',
                prefixIcon: Icon(Icons.rule),
                helperText: 'Conventional commit prefixes to group by',
                helperMaxLines: 2,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.blue[300],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'How prefix rules work',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Commits starting with these prefixes get grouped:\n'
                    '• feat: Add login page → Features\n'
                    '• fix: Cart sync issue → Bug Fixes\n'
                    '• refactor: Auth logic → Improvements',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // exclude patterns
            TextFormField(
              controller: _excludePatternsController,
              decoration: const InputDecoration(
                labelText: 'Exclude Patterns (optional)',
                hintText: 'bot@example.com,merge,WIP',
                prefixIcon: Icon(Icons.filter_alt),
                helperText: 'Skip commits containing these keywords or emails',
                helperMaxLines: 2,
              ),
            ),
            const SizedBox(height: 24),

            // active toggle
            SwitchListTile(
              title: const Text('Active'),
              subtitle: const Text('Include in report generation'),
              value: _isActive,
              onChanged: (value) {
                setState(() => _isActive = value);
              },
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
                  : Text(_isEditing ? 'Save Changes' : 'Add Repository'),
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
      final repo = Repository(
        id: widget.repository?.id,
        companyId: widget.company.id!,
        provider: _provider,
        repoName: _repoNameController.text.trim(),
        branch: _branchController.text.trim(),
        prefixRules: _prefixRulesController.text.trim().isNotEmpty
            ? _prefixRulesController.text.trim()
            : null,
        excludePatterns: _excludePatternsController.text.trim().isNotEmpty
            ? _excludePatternsController.text.trim()
            : null,
        isActive: _isActive,
        createdAt: widget.repository?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isEditing) {
        await client.repository.update(repo);
      } else {
        await client.repository.create(repo);
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
