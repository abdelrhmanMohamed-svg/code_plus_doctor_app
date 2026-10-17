import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/image_assets.dart';
import '../../../../../core/utils/pref_helper.dart';

/// Map card on the Doctor Details screen.
///
/// The design ships a static map image; the clinic location is represented
/// here with the central clinic location and location pin.
class LocationMapCard extends StatelessWidget {
  const LocationMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 210.h,
      decoration: BoxDecoration(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage(ImageAssets.map),
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: FutureBuilder<String>(
                future: PrefHelper.getClinicLocation(),
                builder: (context, snapshot) {
                  final location =
                      snapshot.data ?? PrefHelper.defaultClinicLocation;
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.08),
                          blurRadius: 8.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            color: AppColors.green, size: 18.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            location,
                            style: context.medium12.dark,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
