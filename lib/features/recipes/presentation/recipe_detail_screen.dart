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
    final notes = <String>[
      if (recipe.hydrationNote != null) 'Hydration: ${recipe.hydrationNote}',
      if (recipe.flourTypeNote != null) 'Flour: ${recipe.flourTypeNote}',
      if (recipe.specialInstruction != null) recipe.specialInstruction!,
      if (recipe.steamOrDutchOvenNote != null)
        'Steam / Dutch oven: ${recipe.steamOrDutchOvenNote}',
    ];

    return OwnBreadScaffold(
      title: recipe.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RecipeLeadImage(recipe: recipe),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.breadType.label, style: AppTypography.label),
                    const SizedBox(height: AppSpacing.xs),
                    Text(recipe.description, style: AppTypography.body),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              Chip(label: Text('${recipe.loafCount.label} · ${recipe.loafSize.label}')),
              Chip(label: Text('${recipe.totalMinutes} min total')),
              Chip(label: Text(recipe.difficulty)),
              if (recipe.firstProofMinutes != null)
                Chip(label: Text('1st proof ${recipe.firstProofMinutes} min')),
              if (recipe.secondProofMinutes != null)
                Chip(label: Text('2nd proof ${recipe.secondProofMinutes} min')),
              Chip(label: Text('Bake ${recipe.bakeMinutes} min @ ${recipe.bakeTemperatureLabel}')),
            ],
          ),
          if (notes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            const Text('Notes', style: AppTypography.title),
            const SizedBox(height: AppSpacing.sm),
            ...notes.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(line, style: AppTypography.bodyMuted),
              ),
            ),
          ],
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
                  leading: CircleAvatar(
                    radius: 16,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(step.name, style: AppTypography.body),
                  subtitle: step.minutes != null
                      ? Text('${step.minutes} min', style: AppTypography.label)
                      : null,
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

class _RecipeLeadImage extends StatelessWidget {
  const _RecipeLeadImage({required this.recipe});

  final BreadRecipe recipe;

  @override
  Widget build(BuildContext context) {
    final url = recipe.imageUrl;
    if (url != null && url.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          url,
          width: 88,
          height: 88,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _Placeholder(recipe: recipe),
        ),
      );
    }
    return _Placeholder(recipe: recipe);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.recipe});

  final BreadRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        recipe.breadType.icon,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
