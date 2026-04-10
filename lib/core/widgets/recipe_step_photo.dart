import 'package:flutter/material.dart';

import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';

/// Full-width step illustration when [assetPath] is bundled.
class RecipeStepPhoto extends StatelessWidget {
  const RecipeStepPhoto({
    super.key,
    required this.assetPath,
    this.height = 200,
  });

  final String assetPath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Image.asset(
          assetPath,
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

/// Compact thumbnail for lists (recipe detail steps).
class RecipeStepPhotoThumb extends StatelessWidget {
  const RecipeStepPhotoThumb({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Image.asset(
        assetPath,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(width: 52, height: 52),
      ),
    );
  }
}
