import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../../shared/models/bread_recipe.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  final BreadRecipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.title, style: AppTypography.title),
              const SizedBox(height: AppSpacing.xs),
              Text(recipe.breadType.label, style: AppTypography.label),
              const SizedBox(height: AppSpacing.sm),
              Text(recipe.description, style: AppTypography.bodyMuted),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  Chip(label: Text('${recipe.totalMinutes} min')),
                  Chip(label: Text(recipe.difficulty)),
                  Chip(
                    label: Text(
                      '${recipe.loafCount.label} · ${recipe.loafSize.label}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
