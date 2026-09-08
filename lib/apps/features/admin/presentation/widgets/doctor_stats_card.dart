import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';

class DoctorStatsCard extends StatelessWidget {
  const DoctorStatsCard({
    super.key,
    required this.totalDoctors,
    required this.activeDoctors,
  });

  final int totalDoctors;
  final int activeDoctors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 75.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.greyBorder, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.person_outline,
              label: context.t.admin.totalDoctors,
              value: totalDoctors.toString(),
            ),
          ),
          Container(width: 1, height: 40.h, color: AppColors.greyBorder),
          Expanded(
            child: _StatItem(
              icon: Icons.person_outline,
              label: context.t.admin.active,
              value: activeDoctors.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenLight.withValues(alpha: 0.1),
            ),
            child: Icon(icon, size: 27.r, color: AppColors.green),
          ),
          SizedBox(width: 15.w),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.regular12GreyBlueDark),
              SizedBox(height: 2.h),
              Text(value, style: context.bold18Green),
            ],
          ),
        ],
      ),
    );
  }
}
