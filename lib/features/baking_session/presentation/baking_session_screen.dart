import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/own_bread_scaffold.dart';
import '../../../shared/models/bread_recipe.dart';
import 'completion_screen.dart';

class BakingSessionScreen extends StatefulWidget {
  const BakingSessionScreen({super.key, required this.recipe});

  final BreadRecipe recipe;

  @override
  State<BakingSessionScreen> createState() => _BakingSessionScreenState();
}

class _BakingSessionScreenState extends State<BakingSessionScreen> {
  int currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    final step = widget.recipe.steps[currentStepIndex];
    final isLast = currentStepIndex == widget.recipe.steps.length - 1;

    return OwnBreadScaffold(
      title: 'Baking Session',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${currentStepIndex + 1} of ${widget.recipe.steps.length}',
            style: AppTypography.label,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(step, style: AppTypography.heading),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (isLast) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => CompletionScreen(recipeName: widget.recipe.title),
                  ),
                );
              } else {
                setState(() {
                  currentStepIndex += 1;
                });
              }
            },
            child: Text(isLast ? 'Finish Bake' : 'Next Step'),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (currentStepIndex > 0)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  currentStepIndex -= 1;
                });
              },
              child: const Text('Previous Step'),
            ),
        ],
      ),
    );
  }
}
