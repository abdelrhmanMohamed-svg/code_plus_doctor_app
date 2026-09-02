import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/utils/image_assets.dart';

/// Compact feature doctor card matching the home _FeatureDoctorCard design.
class FavouriteFeatureDoctorCard extends StatelessWidget {
  const FavouriteFeatureDoctorCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
  });

  final String name;
  final String price;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ImageAssets.homeProfile,
              width: 54.r,
              height: 54.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            style: context.medium12Dark,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(price, style: context.regular9GreenMint),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 10.r, color: AppColors.yellowWarm),
              SizedBox(width: 2.w),
              Text(rating, style: context.regular10Grey),
            ],
          ),
        ],
      ),
    );
  }
}
