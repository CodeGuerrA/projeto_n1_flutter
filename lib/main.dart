import 'package:flutter/material.dart';
import 'routes.dart';
import 'services/data_service.dart';
import 'ui/app_theme.dart';
import 'services/auth_service.dart';
import 'services/app_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPrefs.init();
  await AuthService.instance.init();
  DataService.instance.initSampleData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initial = AppPrefs.onboardingSkipped ? Routes.login : Routes.splash;
    return MaterialApp(
      title: 'N1 Projeto',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      initialRoute: initial,
      routes: Routes.routes,
    );
  }
}
