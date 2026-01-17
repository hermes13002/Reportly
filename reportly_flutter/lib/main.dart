import 'package:reportly_client/reportly_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/company/screens/company_list_screen.dart';

/// global client
late final Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();

  runApp(const ReportlyApp());
}

class ReportlyApp extends StatelessWidget {
  const ReportlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reportly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const CompanyListScreen(),
    );
  }
}
