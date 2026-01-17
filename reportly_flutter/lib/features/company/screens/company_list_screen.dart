import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'company_form_screen.dart';
import '../../repository/screens/repository_list_screen.dart';
import '../../report/screens/report_list_screen.dart';
import '../../report/screens/history_screen.dart';

/// main dashboard showing all companies
class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  List<Company>? _companies;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final companies = await client.company.list();
      setState(() {
        _companies = companies;
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
        title: const Text('Reportly'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Report History',
            onPressed: _navigateToHistory,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // todo: navigate to settings
            },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(null),
        icon: const Icon(Icons.add),
        label: const Text('Add Company'),
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
            Text(
              'Error loading companies',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_error!, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadCompanies,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_companies == null || _companies!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No companies yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first company to start generating reports',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCompanies,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _companies!.length,
        itemBuilder: (context, index) => _buildCompanyCard(_companies![index]),
      ),
    );
  }

  Widget _buildCompanyCard(Company company) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToReports(company),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // company avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    company.name.isNotEmpty
                        ? company.name[0].toUpperCase()
                        : 'C',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // company info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company.description ?? 'No description',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildChip(company.reportFrequency),
                        const SizedBox(width: 8),
                        if (company.aiEnabled)
                          _buildChip('AI', color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              // actions
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    _navigateToForm(company);
                  } else if (value == 'repos') {
                    _navigateToRepositories(company);
                  } else if (value == 'delete') {
                    await _deleteCompany(company);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(
                    value: 'repos',
                    child: Text('Repositories'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(
          0.2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Future<void> _navigateToForm(Company? company) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyFormScreen(company: company),
      ),
    );
    if (result == true) {
      _loadCompanies();
    }
  }

  void _navigateToRepositories(Company company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepositoryListScreen(company: company),
      ),
    );
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  void _navigateToReports(Company company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportListScreen(company: company),
      ),
    );
  }

  Future<void> _deleteCompany(Company company) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Company'),
        content: Text('Are you sure you want to delete "${company.name}"?'),
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

    if (confirmed == true && company.id != null) {
      try {
        await client.company.delete(company.id!);
        _loadCompanies();
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
