import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reportly_client/reportly_client.dart';
import '../controllers/company_controller.dart';
import 'company_form_screen.dart';
import '../../repository/screens/repository_list_screen.dart';
import '../../report/screens/report_list_screen.dart';
import '../../settings/screens/delivery_channel_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../template/screens/template_list_screen.dart';

/// Company list screen - "My Companies"
class CompanyListScreen extends StatelessWidget {
  const CompanyListScreen({super.key});

  CompanyController get controller => Get.find<CompanyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(() => _buildBody(context)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(null),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Text(
            'My Companies',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const Spacer(),
          // Settings Icon
          IconButton(
            onPressed: () => Get.to(() => const SettingsScreen()),
            icon: const Icon(Icons.settings_outlined),
            color: Theme.of(context).iconTheme.color,
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error.value != null) {
      return Center(child: Text('Error: ${controller.error.value}'));
    }

    return RefreshIndicator(
      onRefresh: () => controller.loadCompanies(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          // Search Bar
          TextField(
            onChanged: (value) => controller.searchCompanies(value),
            decoration: InputDecoration(
              hintText: 'Search clients...',
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
          const SizedBox(height: 24),

          // Summary Cards
          Row(
            children: [
              // Active Repos Card (Purple Gradient)
              Expanded(
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ACTIVE REPOS',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Stats
                      Obx(
                        () => Text(
                          '${controller.stats['activeRepos'] ?? 0}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Reports Due Card
              Expanded(
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'REPORTS DUE',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Stats
                      Obx(
                        () => Text(
                          '${controller.stats['pendingReports'] ?? 0}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // "Managed Entities" Title
          Text(
            'Managed Entities',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),

          // Company List
          if (controller.filteredCompanies.isEmpty) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'No companies found.',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ),
          ] else
            ...controller.filteredCompanies.map(
              (company) => _buildCompanyTile(context, company),
            ),

          // Bottom padding for FAB
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCompanyTile(BuildContext context, Company company) {
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
        onTap: () => Get.to(() => ReportListScreen(company: company)),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top Row: Icon + Name/Status + Menu
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Box
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).scaffoldBackgroundColor, // Slightly darker/different than card
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        company.name.isNotEmpty
                            ? company.name[0].toUpperCase()
                            : 'C',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name and Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Status indicator
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: company.aiEnabled
                                    ? const Color(
                                        0xFF4CAF50,
                                      ) // Green for Active
                                    : Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              company.aiEnabled ? 'Active' : 'Syncing Data...',
                              style: TextStyle(
                                fontSize: 13,
                                color: company.aiEnabled
                                    ? const Color(0xFF4CAF50)
                                    : Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Menu
                  _buildMenu(context, company),
                ],
              ),
              const SizedBox(height: 20),
              Divider(height: 1, color: Theme.of(context).dividerColor),
              const SizedBox(height: 16),
              // Bottom Row: Stats and Link
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  // View Details Link
                  Text(
                    'VIEW DETAILS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, Company company) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
      ),
      color: Theme.of(context).cardColor,
      surfaceTintColor: Theme.of(context).cardColor,
      onSelected: (value) async {
        if (value == 'edit') {
          _navigateToForm(company);
        } else if (value == 'repos') {
          Get.to(() => RepositoryListScreen(company: company));
        } else if (value == 'channels') {
          Get.to(() => DeliveryChannelScreen(company: company));
        } else if (value == 'templates') {
          Get.to(() => TemplateListScreen(company: company));
        } else if (value == 'delete') {
          await _deleteCompany(company);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Text(
            'Edit Settings',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'repos',
          child: Text(
            'Repositories',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'channels',
          child: Text(
            'Delivery Channels',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'templates',
          child: Text(
            'Report Templates',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: Color(0xFFEF4444))),
        ),
      ],
    );
  }

  Future<void> _navigateToForm(Company? company) async {
    final result = await Get.to<bool>(
      () => CompanyFormScreen(company: company),
    );
    if (result == true) controller.loadCompanies();
  }

  Future<void> _deleteCompany(Company company) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Get.theme.cardColor,
        surfaceTintColor: Get.theme.cardColor,
        title: Text(
          'Delete Company',
          style: TextStyle(color: Get.theme.textTheme.titleLarge?.color),
        ),
        content: Text(
          'Delete "${company.name}"?',
          style: TextStyle(color: Get.theme.textTheme.bodyMedium?.color),
        ),
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

    if (confirmed == true && company.id != null) {
      await controller.deleteCompany(company.id!);
    }
  }
}
