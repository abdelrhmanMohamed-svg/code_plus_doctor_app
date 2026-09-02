import 'package:doctor_hunt/apps/core/utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// Map card on the Doctor Details screen.
///
/// The design ships a static map image; the clinic location is represented
/// here with the design's green location pin on a light placeholder tile.
class LocationMapCard extends StatelessWidget {
  const LocationMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 210.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.map),
          fit: BoxFit.cover,
        ),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 30.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
