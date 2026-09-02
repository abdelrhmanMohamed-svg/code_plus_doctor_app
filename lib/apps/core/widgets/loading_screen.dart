import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../i18n/strings.g.dart';
import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';
import '../utils/image_assets.dart';
import 'blurred_blob.dart';

/// Full-screen splash displayed while auth status is being determined.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundBlobs(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageAssets.logo, width: 100.r, height: 100.r),
                SizedBox(height: 16.h),
                Text(
                  context.t.common.brandName,
                  style: context.bold24Black,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
