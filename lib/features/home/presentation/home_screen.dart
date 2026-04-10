import 'package:flutter/material.dart';

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
          ? const Center(
        child: Text('No breads yet'),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _recipes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final recipe = _recipes[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _openRecipe(recipe),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (recipe.isUserCreated)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Your recipe',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}