import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/recipe_step_images.dart';
import '../../../core/widgets/analog_timer.dart';
import '../../../core/widgets/own_bread_scaffold.dart';
import '../../../core/widgets/recipe_step_photo.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final stepAsset = assetForStepName(step.name);
    final hasTimer = step.minutes != null;

    return OwnBreadScaffold(
      title: 'Baking Session',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${currentStepIndex + 1} of ${widget.recipe.steps.length}',
            style: textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(step.name, style: textTheme.headlineMedium),
          if (stepAsset != null) RecipeStepPhoto(assetPath: stepAsset),
          if (hasTimer) ...[
            const SizedBox(height: AppSpacing.sm),
            Chip(
              avatar: const Icon(Icons.timer_outlined, size: 18),
              label: Text('${step.minutes} min suggested'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Center(
                  child: AnalogTimer(
                    key: ValueKey(
                      'step_${currentStepIndex}_${step.minutes}',
                    ),
                    duration: Duration(minutes: step.minutes!),
                    label: 'Step timer',
                  ),
                ),
              ),
            ),
          ] else
            const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (isLast) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        CompletionScreen(recipeName: widget.recipe.title),
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
