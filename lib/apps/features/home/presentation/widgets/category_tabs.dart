import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_assets.dart';

/// Horizontal scroll of icon-only category tiles.
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  static const List<_CategoryTab> _tabs = [
    _CategoryTab(
      AppColors.categoryBlueStart,
      AppColors.categoryBlueEnd,
      ImageAssets.categoryBody,
    ),
    _CategoryTab(
      AppColors.primary,
      AppColors.gradientEnd,
      ImageAssets.categoryEye,
    ),
    _CategoryTab(
      AppColors.categoryOrangeStart,
      AppColors.categoryOrangeEnd,
      ImageAssets.categoryHeart,
    ),
    _CategoryTab(
      AppColors.categoryRedStart,
      AppColors.categoryRedEnd,
      ImageAssets.categoryTeeth,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 119.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) => _CategoryTile(tab: _tabs[index]),
      ),
    );
  }
}

class _CategoryTab {
  const _CategoryTab(this.gradientStart, this.gradientEnd, this.icon);

  final Color gradientStart;
  final Color gradientEnd;
  final String icon;
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.tab});

  final _CategoryTab tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 90.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tab.gradientStart, tab.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Image.asset(
          tab.icon,
          width: 36.w,
          height: 36.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
