import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  ThemeController get themeController => Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // const SizedBox(height: 32),

          // Theme Section
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Obx(() {
            final isDark = themeController.themeMode == ThemeMode.dark;
            return Card(
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: Text(
                  isDark ? 'Dark theme enabled' : 'Light theme enabled',
                ),
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).primaryColor,
                ),
                value: isDark,
                onChanged: (_) => themeController.toggleTheme(),
              ),
            );
          }),
          // const SizedBox(height: 50),

          // App Logo
          Center(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/app-logo.png',
                width: 250,
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
