import 'package:flutter/material.dart';
import 'package:goose/app_router/app_router.dart';
import 'package:goose/app_theme/app_theme.dart';

class GooseApp extends StatelessWidget {
  const GooseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
