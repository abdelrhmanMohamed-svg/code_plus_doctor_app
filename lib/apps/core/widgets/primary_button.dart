import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/style_atom.dart';

/// A reusable primary action button.
///
/// When [onTap] is null the button is decorative (no ripple), matching
/// the non-tappable pill pattern used in doctor cards.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.width = 295,
    this.height = 54,
    this.borderRadius = 12,
    this.labelStyle,
    this.boxShadow,
  });

  final String label;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double borderRadius;
  final TextStyle? labelStyle;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.background,
      fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
    );

    final effectiveStyle = labelStyle ?? defaultStyle;

    final button = Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: SizedBox(
          width: width.w,
          height: height.h,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: effectiveStyle,
            ),
          ),
        ),
      ),
    );

    final effectiveButton = boxShadow != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius.r),
              boxShadow: boxShadow,
            ),
            child: button,
          )
        : button;

    return Align(
      alignment: Alignment.center,
      child: effectiveButton,
    );
  }
}
