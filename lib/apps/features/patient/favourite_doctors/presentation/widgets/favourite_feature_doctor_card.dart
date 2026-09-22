import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/models/doctor.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';

/// Compact feature doctor card matching the home _FeatureDoctorCard design.
class FavouriteFeatureDoctorCard extends StatelessWidget {
  const FavouriteFeatureDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.doctorDetails, extra: doctor),
      child: Container(
        width: 96.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayLight,
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                doctor.photo,
                width: 54.r,
                height: 54.r,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              doctor.name,
              style: context.medium12Dark,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(doctor.price, style: context.regular9GreenMint),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, size: 10.r, color: AppColors.yellowWarm),
                SizedBox(width: 2.w),
                Text(
                  doctor.rating.toStringAsFixed(1),
                  style: context.regular10Grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
