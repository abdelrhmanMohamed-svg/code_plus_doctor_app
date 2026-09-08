import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';

class DoctorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DoctorsAppBar({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
  });

  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.green,

      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (title != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.semiBold18White,
                    ),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: leading ?? const SizedBox.shrink(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: trailing ?? const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
