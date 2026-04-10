import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';

/// Shell aligned with [AppTheme]: background and app bar from theme tokens.
class OwnBreadScaffold extends StatelessWidget {
  const OwnBreadScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}
