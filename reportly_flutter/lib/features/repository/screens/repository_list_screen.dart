import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'repository_form_screen.dart';

/// repository list for a company - "Connected Repos"
class RepositoryListScreen extends StatefulWidget {
  final Company? company;

  const RepositoryListScreen({super.key, this.company});

  @override
  State<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  List<Repository>? _repositories;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRepositories();
  }

  Future<void> _loadRepositories() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repos = widget.company != null
          ? await client.repository.listByCompany(widget.company!.id!)
          : await _loadAllRepositories();

      setState(() {
        _repositories = repos;
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<List<Repository>> _loadAllRepositories() async {
    try {
      final companies = await client.company.list();
      final futures = companies.map(
        (c) => client.repository.listByCompany(c.id!),
      );
      final results = await Future.wait(futures);

      // Flatten
      return results.expand((i) => i).toList();
    } catch (e) {
      // In a real app we might want to show this error, but for now return empty
      // to avoid breaking the UI for partial failures in this aggregation
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Connected Repos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                // Mock sync all functionality
                Get.snackbar(
                  'Syncing',
                  'Syncing all repositories...',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  isDismissible: true,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Sync All'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search repositories...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: widget.company != null
          ? FloatingActionButton.extended(
              onPressed: () => _navigateToForm(null),
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add Repo',
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
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
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: $_error',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            TextButton(
              onPressed: _loadRepositories,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_repositories == null || _repositories!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.code_off,
              size: 64,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            const SizedBox(height: 16),
            Text(
              'No repositories connected',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRepositories,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _repositories!.length,
        itemBuilder: (context, index) => _buildRepoTile(_repositories![index]),
      ),
    );
  }

  Widget _buildRepoTile(Repository repo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          repo.repoName,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: repo.isActive ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Branch: ${repo.branch}', // Simplified for now
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: repo.isActive,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (val) => _toggleActive(repo),
            ),
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
              ),
              color: Theme.of(context).cardColor,
              surfaceTintColor: Theme.of(context).cardColor,
              onSelected: (value) async {
                if (value == 'edit') {
                  _navigateToForm(repo);
                } else if (value == 'delete') {
                  await _deleteRepo(repo);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToForm(Repository? repo) async {
    if (widget.company == null && repo == null)
      return; // Should be covered by FAB check

    // If company is null (All Repos view), we need a company for the form.
    // Logic: If editing (repo != null), fetch the repo's company.
    // If creating (repo == null), we can't do it without a selected company.

    // For now, disabling edit in 'All Repos' view to avoid complexity or assuming company is available
    if (widget.company == null) {
      Get.snackbar(
        'Notice',
        'Please go to specific company to edit repositories.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => RepositoryFormScreen(
          company: widget.company!, // Safe now
          repository: repo,
        ),
      ),
    );
    if (result == true) _loadRepositories();
  }

  Future<void> _toggleActive(Repository repo) async {
    // Optimistic UI update could be done here, but safe to reload for now
    try {
      await client.repository.toggleActive(repo.id!);
      _loadRepositories();
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to toggle: $e',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
      }
    }
  }

  Future<void> _deleteRepo(Repository repo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        surfaceTintColor: Theme.of(context).cardColor,
        title: Text(
          'Delete Repository',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        content: Text(
          'Delete "${repo.repoName}"?',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && repo.id != null) {
      await client.repository.delete(repo.id!);
      _loadRepositories();
    }
  }
}
