import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Static search input shown overlapping the profile header.
///
/// Tapping it opens the Find Doctors screen.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(6.r),
      child: InkWell(
        onTap: () => context.push(AppRouter.findDoctors),
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.overlayLight,
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Icon(Icons.search, size: 20.r, color: AppColors.grey),
              SizedBox(width: 16.w),
              Text(context.t.home.searchHint, style: context.regular15Grey),
            ],
          ),
        ),
      ),
    );
  }
}
