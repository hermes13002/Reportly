import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// report preview and edit screen
class ReportPreviewScreen extends StatefulWidget {
  final Company company;
  final Report report;

  const ReportPreviewScreen({
    super.key,
    required this.company,
    required this.report,
  });

  @override
  State<ReportPreviewScreen> createState() => _ReportPreviewScreenState();
}

class _ReportPreviewScreenState extends State<ReportPreviewScreen> {
  late TextEditingController _contentController;
  late TextEditingController _notesController;
  bool _editing = false;
  bool _saving = false;
  bool _sending = false;

  bool get _isDraft => widget.report.status == 'draft';

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.report.content);
    _notesController = TextEditingController(text: widget.report.notes ?? '');

    // log report data
    _logReportData();
  }

  void _logReportData() {
    dev.log('=== Opening Report Preview ===', name: 'ReportPreview');
    dev.log('Company: ${widget.company.name}', name: 'ReportPreview');
    dev.log('Report ID: ${widget.report.id}', name: 'ReportPreview');
    dev.log('Status: ${widget.report.status}', name: 'ReportPreview');
    dev.log(
      'Date Range: ${widget.report.startDate} - ${widget.report.endDate}',
      name: 'ReportPreview',
    );

    // log preview of content
    final contentPreview = widget.report.content.length > 100
        ? '${widget.report.content.substring(0, 100)}...'
        : widget.report.content;
    dev.log('Generated Report Preview: $contentPreview', name: 'ReportPreview');

    // log commits preview
    if (widget.report.rawCommitsJson != null) {
      try {
        final decoded = jsonDecode(widget.report.rawCommitsJson!);

        if (decoded is Map) {
          // grouped by type: {feat: [...], fix: [...], other: [...]}
          int totalCommits = 0;
          decoded.forEach((type, messages) {
            if (messages is List) {
              totalCommits += messages.length;
              dev.log(
                '$type: ${messages.length} commits',
                name: 'ReportPreview',
              );
              if (messages.isNotEmpty) {
                final firstMsg = messages.first.toString();
                final preview = firstMsg.length > 40
                    ? '${firstMsg.substring(0, 40)}...'
                    : firstMsg;
                dev.log('  First: $preview', name: 'ReportPreview');
              }
            }
          });
          dev.log('Total Commits: $totalCommits', name: 'ReportPreview');
        }
      } catch (e) {
        dev.log('Error parsing commits: $e', name: 'ReportPreview');
      }
    } else {
      dev.log('No raw commits data', name: 'ReportPreview');
    }
    dev.log('=== End Report Preview Log ===', name: 'ReportPreview');
  }

  @override
  void dispose() {
    _contentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isDraft ? 'Draft Report' : 'Sent Report'),
        actions: [
          if (_isDraft) ...[
            IconButton(
              icon: Icon(_editing ? Icons.check : Icons.edit),
              onPressed: _toggleEdit,
            ),
          ],
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copyToClipboard,
          ),
        ],
      ),
      body: Column(
        children: [
          // status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: _isDraft
                ? Colors.orange.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  _isDraft ? Icons.edit : Icons.check_circle,
                  color: _isDraft ? Colors.orange : Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _isDraft
                      ? 'Draft - Review and send when ready'
                      : 'Sent on ${_formatDate(widget.report.sentAt!)}',
                  style: TextStyle(
                    color: _isDraft ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
          ),

          // content
          Expanded(
            child: _editing ? _buildEditView() : _buildPreviewView(),
          ),

          // actions
          if (_isDraft)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _saving ? null : _regenerate,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Regenerate'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _sending ? null : _send,
                      icon: _sending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      label: Text(_sending ? 'Sending...' : 'Send'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPreviewView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // date range
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        '${_formatDate(widget.report.startDate)} - ${_formatDate(widget.report.endDate)}',
                      ),
                    ],
                  ),
                  if (widget.report.aiSummary != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'AI',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // raw commits section
          if (widget.report.rawCommitsJson != null &&
              widget.report.rawCommitsJson!.isNotEmpty)
            _buildCommitsSection(),

          // generated report section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.article,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated Report',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  MarkdownBody(
                    data: widget.report.content,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      h1: Theme.of(context).textTheme.headlineLarge,
                      h2: Theme.of(context).textTheme.headlineMedium,
                      h3: Theme.of(context).textTheme.titleLarge,
                      p: Theme.of(context).textTheme.bodyMedium,
                      listBullet: Theme.of(context).textTheme.bodyMedium,
                      strong: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // notes
          if (widget.report.notes != null &&
              widget.report.notes!.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Notes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(widget.report.notes!),
          ],
        ],
      ),
    );
  }

  Widget _buildCommitsSection() {
    Map<String, List<String>> groupedCommits = {};
    int totalCommits = 0;

    try {
      final decoded = jsonDecode(widget.report.rawCommitsJson!);
      if (decoded is Map) {
        decoded.forEach((type, messages) {
          if (messages is List) {
            groupedCommits[type.toString()] = messages.cast<String>();
            totalCommits += messages.length;
          }
        });
      }
    } catch (e) {
      // invalid json, skip
    }

    if (totalCommits == 0) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.commit,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Raw Commits ($totalCommits)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 250),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: groupedCommits.entries.map((entry) {
                    final type = entry.key;
                    final messages = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // type header
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(type).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${type.toUpperCase()} (${messages.length})',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: _getTypeColor(type),
                            ),
                          ),
                        ),
                        // messages
                        ...messages.map(
                          (msg) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    msg,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'feat':
        return Colors.green;
      case 'fix':
        return Colors.orange;
      case 'refactor':
        return Colors.blue;
      case 'docs':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildEditView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report Content',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contentController,
            maxLines: null,
            minLines: 15,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Report content...',
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Notes (optional)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add any additional notes...',
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _toggleEdit() async {
    if (_editing) {
      // save changes
      setState(() => _saving = true);
      try {
        final updated = widget.report.copyWith(
          content: _contentController.text,
          notes: _notesController.text.isNotEmpty
              ? _notesController.text
              : null,
        );
        await client.report.update(updated);
        widget.report.content = _contentController.text;
        widget.report.notes = _notesController.text.isNotEmpty
            ? _notesController.text
            : null;
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving: $e')),
          );
        }
      } finally {
        setState(() {
          _saving = false;
          _editing = false;
        });
      }
    } else {
      setState(() => _editing = true);
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.report.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  Future<void> _regenerate() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Regenerate Report'),
        content: const Text('This will replace the current content. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Regenerate'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _saving = true);
    try {
      final newReport = await client.reportGeneration.regenerate(
        widget.report.id!,
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReportPreviewScreen(
              company: widget.company,
              report: newReport,
            ),
          ),
        );
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

  Future<void> _send() async {
    // show delivery options
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Send via Email'),
              onTap: () => Navigator.pop(context, 'email'),
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Mark as Sent (Manual)'),
              onTap: () => Navigator.pop(context, 'manual'),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (choice == null) return;

    setState(() => _sending = true);
    try {
      if (choice == 'manual') {
        // use the send method which finds default channel
        // or we can create a manual channel on the fly
        await client.report.markSent(widget.report.id!, 'manual');
      } else {
        // send via default channel
        await client.reportGeneration.send(widget.report.id!);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report sent successfully!')),
        );
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
        setState(() => _sending = false);
      }
    }
  }
}
