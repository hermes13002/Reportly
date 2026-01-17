import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'report_preview_screen.dart';

/// global history screen showing all reports across companies
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Report>? _reports;
  List<Company>? _companies;
  bool _loading = true;
  String? _error;

  String _searchQuery = '';
  int? _selectedCompanyId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // load all companies
      final companies = await client.company.list();

      // load reports from all companies
      final allReports = <Report>[];
      for (final company in companies) {
        final sent = await client.report.listByCompany(
          company.id!,
          status: 'sent',
          limit: 50,
          offset: 0,
        );
        allReports.addAll(sent);
      }

      // sort by sentAt descending
      allReports.sort((a, b) {
        final aDate = a.sentAt ?? a.createdAt;
        final bDate = b.sentAt ?? b.createdAt;
        return bDate.compareTo(aDate);
      });

      setState(() {
        _companies = companies;
        _reports = allReports;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  List<Report> get _filteredReports {
    if (_reports == null) return [];

    var filtered = _reports!;

    // filter by company
    if (_selectedCompanyId != null) {
      filtered = filtered
          .where((r) => r.companyId == _selectedCompanyId)
          .toList();
    }

    // filter by search query (date range)
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((r) {
        final dateRange =
            '${_formatDate(r.startDate)} - ${_formatDate(r.endDate)}';
        return dateRange.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  String _getCompanyName(int companyId) {
    return _companies
            ?.firstWhere(
              (c) => c.id == companyId,
              orElse: () => Company(
                name: 'Unknown',
                timezone: 'UTC',
                reportFrequency: 'weekly',
                aiEnabled: false,
                toneSetting: 'neutral',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            )
            .name ??
        'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report History'),
      ),
      body: Column(
        children: [
          // search and filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // search field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by date...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                const SizedBox(height: 12),

                // company filter
                if (_companies != null && _companies!.isNotEmpty)
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: const Text('All Companies'),
                            selected: _selectedCompanyId == null,
                            onSelected: (selected) {
                              setState(() => _selectedCompanyId = null);
                            },
                          ),
                        ),
                        ..._companies!.map(
                          (company) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(company.name),
                              selected: _selectedCompanyId == company.id,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCompanyId = selected
                                      ? company.id
                                      : null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // reports list
          Expanded(
            child: _buildBody(),
          ),
        ],
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
            Text('Error loading history'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final reports = _filteredReports;

    if (reports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              _selectedCompanyId != null || _searchQuery.isNotEmpty
                  ? 'No matching reports found'
                  : 'No sent reports yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: reports.length,
        itemBuilder: (context, index) => _buildReportCard(reports[index]),
      ),
    );
  }

  Widget _buildReportCard(Report report) {
    final companyName = _getCompanyName(report.companyId);
    final dateRange =
        '${_formatDate(report.startDate)} - ${_formatDate(report.endDate)}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToPreview(report),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check_circle, color: Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateRange,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.send, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          'Sent ${_formatDate(report.sentAt ?? report.createdAt)} via ${report.deliveryChannel ?? 'unknown'}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _navigateToPreview(Report report) {
    final company = _companies?.firstWhere(
      (c) => c.id == report.companyId,
      orElse: () => Company(
        name: 'Unknown',
        timezone: 'UTC',
        reportFrequency: 'weekly',
        aiEnabled: false,
        toneSetting: 'neutral',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPreviewScreen(
          company: company!,
          report: report,
        ),
      ),
    );
  }
}
