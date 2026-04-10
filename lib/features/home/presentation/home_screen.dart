import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../shared/models/bread_recipe.dart';
import '../../recipes/data/mock_recipes.dart';
import '../../recipes/presentation/create_bread_screen.dart';
import '../../recipes/presentation/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<BreadRecipe> _recipes;

  @override
  void initState() {
    super.initState();
    _recipes = List<BreadRecipe>.from(mockBreadRecipes);
  }

  Future<void> _openCreateBread() async {
    final BreadRecipe? newRecipe = await Navigator.of(context).push<BreadRecipe>(
      MaterialPageRoute(
        builder: (_) => const CreateBreadScreen(),
      ),
    );

    if (newRecipe != null) {
      setState(() {
        _recipes.insert(0, newRecipe);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${newRecipe.title}" added successfully'),
        ),
      );
    }
  }

  void _openRecipe(BreadRecipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Own Bread'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateBread,
        icon: const Icon(Icons.add),
        label: const Text('Add Your Bread'),
      ),
      body: _recipes.isEmpty
          ? Center(
              child: Text(
                'No breads yet',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: _recipes.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final recipe = _recipes[index];

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            onTap: () => _openRecipe(recipe),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      if (recipe.isUserCreated)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            'Your recipe',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    recipe.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _InfoChip(
                        icon: recipe.breadType.icon,
                        label: recipe.breadType.label,
                      ),
                      _InfoChip(
                        icon: Icons.schedule_outlined,
                        label: '${recipe.totalMinutes} min',
                      ),
                      _InfoChip(
                        icon: Icons.local_fire_department_outlined,
                        label: recipe.difficulty,
                      ),
                      _InfoChip(
                        icon: Icons.format_list_numbered,
                        label: '${recipe.steps.length} steps',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}