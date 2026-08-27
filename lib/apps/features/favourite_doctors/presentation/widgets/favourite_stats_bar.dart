import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

/// Four-box stats row shown on the Favourite Doctors screen.
class FavouriteStatsBar extends StatelessWidget {
  const FavouriteStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          _StatBox(value: '12', label: context.t.favouriteDoctors.statsRunning),
          SizedBox(width: 8.w),
          _StatBox(value: '24', label: context.t.favouriteDoctors.statsOngoing),
          SizedBox(width: 8.w),
          _StatBox(
            value: '132',
            label: context.t.favouriteDoctors.statsPatient,
          ),
          SizedBox(width: 8.w),
          _StatBox(value: '4.5', label: context.t.favouriteDoctors.statsReview),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: AppColors.statBoxGrey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: StyleAtom.statsValue),
            SizedBox(height: 3.h),
            Text(label, style: StyleAtom.statsLabel),
          ],
        ),
      ),
    );
  }
}
