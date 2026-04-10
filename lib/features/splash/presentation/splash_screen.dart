import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../home/presentation/home_screen.dart';

/// In-app splash: hero image with soft edge fade, then [HomeScreen] after 3s.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _asset = 'assets/images/french-bread.jpg';
  static const _displayDuration = Duration(seconds: 3);

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();

    Timer(_displayDuration, () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _EdgeFadeImage(
                    width: size.width * 0.96,
                    height: size.height * 0.62,
                    assetPath: _asset,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 48,
                child: Text(
                  'Own Bread',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Large cover image with radial fade into [AppColors.background] at the edges.
class _EdgeFadeImage extends StatelessWidget {
  const _EdgeFadeImage({
    required this.width,
    required this.height,
    required this.assetPath,
  });

  final double width;
  final double height;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              assetPath,
              fit: BoxFit.cover,
              width: width,
              height: height,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: AppColors.surfaceMuted,
                child: Icon(
                  Icons.bakery_dining_outlined,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
            ),
            // Soft vignette: blend image into page background at edges.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.05,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.0),
                    AppColors.background.withValues(alpha: 0.55),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.45, 0.78, 1.0],
                ),
              ),
            ),
            // Extra linear fades on top/bottom for a softer “fade in” frame.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.45),
                  ],
                  stops: const [0.0, 0.12, 0.88, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
