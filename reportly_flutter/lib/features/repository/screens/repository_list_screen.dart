import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'repository_form_screen.dart';

/// repository list for a company
class RepositoryListScreen extends StatefulWidget {
  final Company company;

  const RepositoryListScreen({super.key, required this.company});

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
      final repos = await client.repository.listByCompany(widget.company.id!);
      setState(() {
        _repositories = repos;
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
        title: Text('${widget.company.name} Repositories'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(null),
        icon: const Icon(Icons.add),
        label: const Text('Add Repository'),
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
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Error loading repositories'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _loadRepositories,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
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
            Icon(Icons.source, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No repositories yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add a GitHub repository to start tracking commits',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRepositories,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _repositories!.length,
        itemBuilder: (context, index) => _buildRepoCard(_repositories![index]),
      ),
    );
  }

  Widget _buildRepoCard(Repository repo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: repo.isActive
                ? Colors.green.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.code,
            color: repo.isActive ? Colors.green : Colors.grey,
          ),
        ),
        title: Text(repo.repoName),
        subtitle: Text('Branch: ${repo.branch}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                repo.isActive ? Icons.visibility : Icons.visibility_off,
                color: repo.isActive ? Colors.green : Colors.grey,
              ),
              onPressed: () => _toggleActive(repo),
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  _navigateToForm(repo);
                } else if (value == 'delete') {
                  await _deleteRepo(repo);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToForm(Repository? repo) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => RepositoryFormScreen(
          company: widget.company,
          repository: repo,
        ),
      ),
    );
    if (result == true) {
      _loadRepositories();
    }
  }

  Future<void> _toggleActive(Repository repo) async {
    try {
      await client.repository.toggleActive(repo.id!);
      _loadRepositories();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteRepo(Repository repo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Repository'),
        content: Text('Are you sure you want to delete "${repo.repoName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && repo.id != null) {
      try {
        await client.repository.delete(repo.id!);
        _loadRepositories();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }
}
