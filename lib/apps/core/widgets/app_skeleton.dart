import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../theme/app_colors.dart';

/// Reusable skeleton shimmer wrapper built on [Skeletonizer].
///
/// Pass [enabled] to toggle between skeleton placeholder and real content.
/// Optionally override [baseColor]/[highlightColor] to adapt to any background.
/// Reuse this widget for any loading skeleton across the app.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    required this.enabled,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1200),
  });

  final bool enabled;
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  static final _defaultBase = AppColors.white.withValues(alpha: 0.3);
  static final _defaultHighlight = AppColors.white.withValues(alpha: 0.6);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect: ShimmerEffect(
        baseColor: baseColor ?? _defaultBase,
        highlightColor: highlightColor ?? _defaultHighlight,
        duration: duration,
      ),
      enableSwitchAnimation: true,
      child: child,
    );
  }
}
