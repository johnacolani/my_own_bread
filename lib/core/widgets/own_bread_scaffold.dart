import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';

class OwnBreadScaffold extends StatelessWidget {
  const OwnBreadScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
  final Color backgroundColor = Colors.white;
  final Icon icon = const Icon(Icons.add);

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
