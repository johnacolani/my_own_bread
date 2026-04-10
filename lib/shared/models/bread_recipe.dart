import 'package:flutter/material.dart';

/// Fixed bread categories for dropdowns and placeholder visuals.
enum BreadType {
  sourdough,
  milkBread,
  baguette,
  focaccia,
  sandwichLoaf,
}

enum LoafCount {
  one,
  two,
}

enum LoafSize {
  small,
  medium,
  large,
}

enum TemperatureUnit {
  celsius,
  fahrenheit,
}

class RecipeStep {
  const RecipeStep({
    required this.name,
    this.minutes,
  });

  final String name;
  final int? minutes;
}

class BreadRecipe {
  const BreadRecipe({
    required this.id,
    required this.title,
    required this.description,
    required this.breadType,
    required this.difficulty,
    required this.totalMinutes,
    required this.loafCount,
    required this.loafSize,
    this.firstProofMinutes,
    this.secondProofMinutes,
    required this.bakeMinutes,
    required this.bakeTemperature,
    required this.temperatureUnit,
    required this.ingredients,
    required this.steps,
    this.hydrationNote,
    this.flourTypeNote,
    this.specialInstruction,
    this.steamOrDutchOvenNote,
    this.imageUrl,
    this.isUserCreated = false,
  });

  final String id;
  final String title;
  final String description;
  final BreadType breadType;
  final String difficulty;
  final int totalMinutes;
  final LoafCount loafCount;
  final LoafSize loafSize;
  final int? firstProofMinutes;
  final int? secondProofMinutes;
  final int bakeMinutes;
  final int bakeTemperature;
  final TemperatureUnit temperatureUnit;
  final List<String> ingredients;
  final List<RecipeStep> steps;
  final String? hydrationNote;
  final String? flourTypeNote;
  final String? specialInstruction;
  final String? steamOrDutchOvenNote;
  final String? imageUrl;
  final bool isUserCreated;

  String get bakeTemperatureLabel {
    final u = temperatureUnit == TemperatureUnit.celsius ? '°C' : '°F';
    return '$bakeTemperature$u';
  }
}

extension BreadTypeLabels on BreadType {
  String get label => switch (this) {
        BreadType.sourdough => 'Sourdough',
        BreadType.milkBread => 'Milk bread',
        BreadType.baguette => 'Baguette',
        BreadType.focaccia => 'Focaccia',
        BreadType.sandwichLoaf => 'Sandwich loaf',
      };

  IconData get icon => switch (this) {
        BreadType.sourdough => Icons.bakery_dining_outlined,
        BreadType.milkBread => Icons.breakfast_dining_outlined,
        BreadType.baguette => Icons.restaurant_outlined,
        BreadType.focaccia => Icons.local_pizza_outlined,
        BreadType.sandwichLoaf => Icons.lunch_dining_outlined,
      };
}

extension LoafCountLabels on LoafCount {
  String get label => switch (this) {
        LoafCount.one => '1 loaf',
        LoafCount.two => '2 loaves',
      };
}

extension LoafSizeLabels on LoafSize {
  String get label => switch (this) {
        LoafSize.small => 'Small',
        LoafSize.medium => 'Medium',
        LoafSize.large => 'Large',
      };
}

extension TemperatureUnitLabels on TemperatureUnit {
  String get shortLabel => switch (this) {
        TemperatureUnit.celsius => '°C',
        TemperatureUnit.fahrenheit => '°F',
      };
}
