import 'package:flutter/material.dart';
import 'package:rick_morthy_app/app_routes.dart';
import 'package:rick_morthy_app/app_routes_manager.dart';
import 'package:rick_morthy_app/core/di/locator.dart';
import 'package:rick_morthy_app/core/utils/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.characterList,
      routes: AppRouteManager.instance.getPages(),
    );
  }
}
