import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

/// Design-derived dimensions for a single onboarding page.
const double _illustrationSize = 336;
const double _blobSize = 342;

/// A single onboarding page: illustration, title and body text.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.illustration,
    required this.title,
    required this.isGradientOnRight,
  });

  final String illustration;
  final String title;
  final bool isGradientOnRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 38.w),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _Illustration(
                illustration: illustration,
                isGradientOnRight: isGradientOnRight,
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: StyleAtom.onboardingTitle,
          ),
          SizedBox(height: 11.h),
          Text(
            context.t.onboarding.body,
            textAlign: TextAlign.center,
            style: StyleAtom.onboardingBody,
          ),
        ],
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration({
    required this.illustration,
    required this.isGradientOnRight,
  });

  final String illustration;
  final bool isGradientOnRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize.w,
      height: _illustrationSize.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isGradientOnRight ? 155.w : -124.w,
            top: -111.w,
            child: Container(
              width: _blobSize.w,
              height: _blobSize.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [AppColors.primary, AppColors.gradientEnd],
                ),
              ),
            ),
          ),
          Image.asset(
            illustration,
            width: _illustrationSize.w,
            height: _illustrationSize.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
