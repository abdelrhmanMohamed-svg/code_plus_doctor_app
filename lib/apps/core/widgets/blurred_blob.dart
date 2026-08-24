import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

/// Soft, blurred circular decorative shape used behind screen content.
class BlurredBlob extends StatelessWidget {
  const BlurredBlob({
    super.key,
    required this.color,
    this.size = 216,
    this.sigma = 60,
  });

  final Color color;
  final double size;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: sigma.r, sigmaY: sigma.r),
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

/// Decorative full-screen background: cyan blob top-left, mint blob bottom-right.
class BackgroundBlobs extends StatelessWidget {
  const BackgroundBlobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -100.w,
          top: -33.h,
          child: BlurredBlob(color: AppColors.blurBlueBlob, sigma: 135),
        ),
        Positioned(
          right: -53.w,
          bottom: -45.h,
          child: BlurredBlob(color: AppColors.blurColorONChooseRule),
        ),
      ],
    );
  }
}
