class BreadRecipe {
  const BreadRecipe({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.totalMinutes,
    required this.ingredients,
    required this.steps,
    this.isUserCreated = false,
  });

  final String id;
  final String title;
  final String description;
  final String difficulty;
  final int totalMinutes;
  final List<String> ingredients;
  final List<String> steps;
  final bool isUserCreated;
}
