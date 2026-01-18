import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';

/// delivery channel list screen
class DeliveryChannelScreen extends StatefulWidget {
  final Company company;

  const DeliveryChannelScreen({super.key, required this.company});

  @override
  State<DeliveryChannelScreen> createState() => _DeliveryChannelScreenState();
}

class _DeliveryChannelScreenState extends State<DeliveryChannelScreen> {
  List<DeliveryChannel>? _channels;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  Future<void> _loadChannels() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final channels = await client.deliveryChannel.listByCompany(
        widget.company.id!,
      );
      setState(() {
        _channels = channels;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Channels'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(null),
        icon: const Icon(Icons.add),
        label: const Text('Add Channel'),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadChannels,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_channels == null || _channels!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send_outlined, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No delivery channels',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add an email channel to send reports automatically',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadChannels,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _channels!.length,
        itemBuilder: (context, index) => _buildChannelCard(_channels![index]),
      ),
    );
  }

  Widget _buildChannelCard(DeliveryChannel channel) {
    final config = _parseConfig(channel.configJson);
    final recipients = (config['recipients'] as List?)?.cast<String>() ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getChannelColor(channel.channelType).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getChannelIcon(channel.channelType),
            color: _getChannelColor(channel.channelType),
          ),
        ),
        title: Row(
          children: [
            Text(channel.name),
            const SizedBox(width: 8),
            if (channel.isDefault)
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
        ),
        subtitle: Text(
          channel.channelType == 'email'
              ? '${recipients.length} recipient(s)'
              : channel.channelType.toUpperCase(),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              _navigateToForm(channel);
            } else if (value == 'default') {
              await _setDefault(channel);
            } else if (value == 'toggle') {
              await _toggleActive(channel);
            } else if (value == 'delete') {
              await _deleteChannel(channel);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            if (!channel.isDefault)
              const PopupMenuItem(
                value: 'default',
                child: Text('Set as Default'),
              ),
            PopupMenuItem(
              value: 'toggle',
              child: Text(channel.isActive ? 'Disable' : 'Enable'),
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

  Map<String, dynamic> _parseConfig(String json) {
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  IconData _getChannelIcon(String type) {
    switch (type) {
      case 'email':
        return Icons.email;
      case 'clickup':
        return Icons.task_alt;
      case 'manual':
        return Icons.content_copy;
      default:
        return Icons.send;
    }
  }

  Color _getChannelColor(String type) {
    switch (type) {
      case 'email':
        return Colors.blue;
      case 'clickup':
        return Colors.purple;
      case 'manual':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _navigateToForm(DeliveryChannel? channel) async {
    final result = await Get.to<bool>(
      () => DeliveryChannelFormScreen(
        company: widget.company,
        channel: channel,
      ),
    );
    if (result == true) {
      _loadChannels();
    }
  }

  Future<void> _setDefault(DeliveryChannel channel) async {
    try {
      await client.deliveryChannel.setDefault(channel.id!);
      _loadChannels();
      Get.snackbar('Success', '${channel.name} set as default');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _toggleActive(DeliveryChannel channel) async {
    try {
      await client.deliveryChannel.toggleActive(channel.id!);
      _loadChannels();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _deleteChannel(DeliveryChannel channel) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Channel'),
        content: Text('Delete "${channel.name}"?'),
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
      try {
        await client.deliveryChannel.delete(channel.id!);
        _loadChannels();
        Get.snackbar('Success', 'Channel deleted');
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }
}

/// delivery channel form screen
class DeliveryChannelFormScreen extends StatefulWidget {
  final Company company;
  final DeliveryChannel? channel;

  const DeliveryChannelFormScreen({
    super.key,
    required this.company,
    this.channel,
  });

  @override
  State<DeliveryChannelFormScreen> createState() =>
      _DeliveryChannelFormScreenState();
}

class _DeliveryChannelFormScreenState extends State<DeliveryChannelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _recipientsController;
  String _channelType = 'email';
  bool _isDefault = false;
  bool _saving = false;

  bool get _isEditing => widget.channel != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.channel?.name ?? '');
    _channelType = widget.channel?.channelType ?? 'email';
    _isDefault = widget.channel?.isDefault ?? false;

    // parse existing recipients
    String recipients = '';
    if (widget.channel?.configJson != null) {
      try {
        final config =
            jsonDecode(widget.channel!.configJson) as Map<String, dynamic>;
        final list = (config['recipients'] as List?)?.cast<String>() ?? [];
        recipients = list.join('\n');
      } catch (e) {
        // ignore
      }
    }
    _recipientsController = TextEditingController(text: recipients);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _recipientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Channel' : 'Add Channel'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // channel type
            Text(
              'Channel Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildTypeChip('email', 'Email', Icons.email),
                _buildTypeChip('manual', 'Manual', Icons.content_copy),
              ],
            ),
            const SizedBox(height: 24),

            // name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Channel Name',
                hintText: 'e.g., Team Email',
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

            // recipients (for email only)
            if (_channelType == 'email') ...[
              TextFormField(
                controller: _recipientsController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Email Recipients',
                  hintText: 'Enter one email per line',
                  prefixIcon: Icon(Icons.people),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (_channelType == 'email' &&
                      (value == null || value.isEmpty)) {
                    return 'Please enter at least one recipient';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Enter each email address on a new line',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
            const SizedBox(height: 24),

            // default toggle
            SwitchListTile(
              title: const Text('Set as Default'),
              subtitle: const Text('Use this channel when sending reports'),
              value: _isDefault,
              onChanged: (value) => setState(() => _isDefault = value),
            ),
            const SizedBox(height: 32),

            // save button
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isEditing ? 'Update Channel' : 'Create Channel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type, String label, IconData icon) {
    final selected = _channelType == type;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: selected ? Colors.white : null),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (value) {
        if (value) setState(() => _channelType = type);
      },
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      // build config
      Map<String, dynamic> config = {};
      if (_channelType == 'email') {
        final recipients = _recipientsController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        config['recipients'] = recipients;
      }

      final channel = DeliveryChannel(
        id: widget.channel?.id,
        companyId: widget.company.id!,
        channelType: _channelType,
        name: _nameController.text.trim(),
        configJson: jsonEncode(config),
        isActive: true,
        isDefault: _isDefault,
        createdAt: widget.channel?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isEditing) {
        await client.deliveryChannel.update(channel);
      } else {
        await client.deliveryChannel.create(channel);
      }

      Get.back(result: true);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
