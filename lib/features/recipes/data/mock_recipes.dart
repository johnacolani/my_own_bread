import '../../../shared/models/bread_recipe.dart';

final List<BreadRecipe> mockBreadRecipes = [
  const BreadRecipe(
    id: '1',
    title: 'Classic Sourdough',
    description: 'Tangy sourdough loaf with crisp crust and airy crumb.',
    difficulty: 'Intermediate',
    totalMinutes: 240,
    ingredients: [
      '500g bread flour',
      '350g water',
      '100g starter',
      '10g salt',
    ],
    steps: [
      'Mix flour and water',
      'Rest for autolyse',
      'Add starter and salt',
      'Stretch and fold',
      'Bulk ferment',
      'Shape dough',
      'Final proof',
      'Bake',
    ],
  ),
  const BreadRecipe(
    id: '2',
    title: 'Soft Milk Bread',
    description: 'Light and soft loaf that works well for toast.',
    difficulty: 'Beginner',
    totalMinutes: 180,
    ingredients: [
      '500g flour',
      '250ml milk',
      '50g sugar',
      '8g yeast',
      '8g salt',
      '40g butter',
    ],
    steps: [
      'Mix ingredients',
      'Knead dough',
      'First rise',
      'Shape loaf',
      'Second rise',
      'Bake',
    ],
  ),
];