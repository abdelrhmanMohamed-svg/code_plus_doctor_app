import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/utils/image_assets.dart';

/// Gradient header with greeting text and profile avatar.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 156.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t.home.greeting, style: StyleAtom.homeGreeting),
                SizedBox(height: 6.h),
                Text(context.t.home.userName, style: StyleAtom.homeUserName),
              ],
            ),
          ),
          ClipOval(
            child: Image.asset(
              ImageAssets.homeProfile,
              width: 60.r,
              height: 60.r,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
