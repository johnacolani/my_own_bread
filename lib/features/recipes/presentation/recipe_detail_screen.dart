import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/own_bread_scaffold.dart';
import '../../../shared/models/bread_recipe.dart';
import '../../baking_session/presentation/baking_session_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final BreadRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return OwnBreadScaffold(
      title: recipe.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.description, style: AppTypography.body),
          const SizedBox(height: AppSpacing.lg),
          const Text('Ingredients', style: AppTypography.title),
          const SizedBox(height: AppSpacing.sm),
          ...recipe.ingredients.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text('• $item', style: AppTypography.bodyMuted),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Text('Steps', style: AppTypography.title),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.builder(
              itemCount: recipe.steps.length,
              itemBuilder: (context, index) {
                final step = recipe.steps[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${index + 1}. $step'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BakingSessionScreen(recipe: recipe),
                ),
              );
            },
            child: const Text('Start Baking Session'),
          ),
        ],
      ),
    );
  }
}
