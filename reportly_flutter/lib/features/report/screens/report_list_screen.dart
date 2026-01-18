import 'package:flutter/material.dart';
import 'package:reportly_client/reportly_client.dart';
import '../../../main.dart';
import 'report_generate_screen.dart';
import 'report_preview_screen.dart';

/// report list for a company - "Project Reports"
class ReportListScreen extends StatefulWidget {
  final Company company;

  const ReportListScreen({super.key, required this.company});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Report>? _allReports;
  List<Report>? _draftReports;
  List<Report>? _sentReports;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadReports();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadReports() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Load drafts and sent reports separately for now (or could filter client side if API supports all)
      final drafts = await client.report.listByCompany(
        widget.company.id!,
        status: 'draft',
        limit: 50,
        offset: 0,
      );
      final sent = await client.report.listByCompany(
        widget.company.id!,
        status: 'sent',
        limit: 50,
        offset: 0,
      );

      final archived = await client.report.listByCompany(
        widget.company.id!,
        status: 'archived',
        limit: 20,
        offset: 0,
      );

      final all = [...drafts, ...sent, ...archived];
      // sort by created desc
      all.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      setState(() {
        _draftReports = drafts;
        _sentReports = sent;
        _allReports = all;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.company.name),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Project Reports',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Drafts'),
                  Tab(text: 'Sent'),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search reports...',
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
            const SizedBox(height: 16),

            // List
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildReportList(_allReports),
                  _buildReportList(_draftReports),
                  _buildReportList(_sentReports),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToGenerate,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text(
          'Generate New',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReportList(List<Report>? reports) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          children: [
            Text(
              'Error loading reports',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            TextButton(onPressed: _loadReports, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (reports == null || reports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            const SizedBox(height: 16),
            Text(
              'No reports found',
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
      onRefresh: _loadReports,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        itemCount: reports.length,
        itemBuilder: (context, index) => _buildReportCard(reports[index]),
      ),
    );
  }

  Widget _buildReportCard(Report report) {
    final dateRange =
        '${_formatDate(report.startDate)} - ${_formatDate(report.endDate)}';
    final isDraft = report.status == 'draft';
    final isSent = report.status == 'sent';

    Color statusColor = Colors.grey;
    String statusText = report.status.toUpperCase();
    if (isDraft) {
      statusColor = Colors.orange;
    } else if (isSent) {
      statusColor = Colors.green;
      statusText = 'SENT';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: () => _navigateToPreview(report),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Title + Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Development Report', // Placeholder title logic, could be dynamic
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium?.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withOpacity(0.5)),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ID and Date
              Row(
                children: [
                  Text(
                    '#${report.id}',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    dateRange,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(height: 1, color: Theme.of(context).dividerColor),
              const SizedBox(height: 16),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isDraft ? 'EDIT REPORT' : 'VIEW REPORT',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  Future<void> _navigateToGenerate() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ReportGenerateScreen(company: widget.company),
      ),
    );
    if (result == true) {
      _loadReports();
    }
  }

  void _navigateToPreview(Report report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPreviewScreen(
          company: widget.company,
          report: report,
        ),
      ),
    ).then((_) => _loadReports());
  }
}
