import 'package:flutter/material.dart';

import '../features/splash/presentation/splash_screen.dart';
import 'theme/app_theme.dart';

class OwnBreadApp extends StatelessWidget {
  const OwnBreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Own Bread',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
