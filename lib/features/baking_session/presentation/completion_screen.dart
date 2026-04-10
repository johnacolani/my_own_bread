import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/own_bread_scaffold.dart';
import '../../home/presentation/home_screen.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.recipeName});

  final String recipeName;

  @override
  Widget build(BuildContext context) {
    return OwnBreadScaffold(
      title: 'Bake Complete',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nice work.', style: AppTypography.heading),
          const SizedBox(height: AppSpacing.md),
          Text(
            'You completed $recipeName. This is where history, notes, and ratings can be added next.',
            style: AppTypography.body,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
