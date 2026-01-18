import 'dart:developer' as dev;
import 'package:reportly_client/reportly_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/api_constants.dart';
import 'core/screens/splash_screen.dart';
import 'features/company/controllers/company_controller.dart';
import 'features/repository/controllers/repository_controller.dart';
import 'features/report/controllers/report_controller.dart';
import 'features/template/controllers/template_controller.dart';
import 'core/theme/theme_controller.dart';

/// global client
late final Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dev.log('Starting Reportly app...', name: 'Main');

  // use hardcoded url from constants (not config.json)
  const serverUrl = ApiConstants.serverUrl;
  dev.log('Server URL: $serverUrl', name: 'Main');

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  dev.log('Client created successfully', name: 'Main');

  client.auth.initialize();
  dev.log('Auth initialized', name: 'Main');

  // register getx controllers
  Get.put(CompanyController());
  Get.put(RepositoryController());
  Get.put(ReportController());
  Get.put(TemplateController());
  Get.put(ThemeController());

  // configure snackbar behavior to prevent duplicates
  Get.config(
    enableLog: false,
    defaultTransition: Transition.fade,
  );

  dev.log('GetX controllers registered', name: 'Main');

  runApp(const ReportlyApp());
}

class ReportlyApp extends StatelessWidget {
  const ReportlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Reportly',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}
