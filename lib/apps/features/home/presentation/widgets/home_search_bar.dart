import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

/// Static search input shown overlapping the profile header.
///
/// Tapping it opens the Find Doctors screen.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(6.r),
      child: InkWell(
        onTap: () => context.push(AppRouter.findDoctors),
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Icon(Icons.search, size: 20.r, color: AppColors.secondary),
              SizedBox(width: 16.w),
              Text(context.t.home.searchHint, style: StyleAtom.homeSearchHint),
            ],
          ),
        ),
      ),
    );
  }
}
