import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';

/// Shows an empty / error placeholder for the admin doctors list.
class EmptyDoctorsView extends StatelessWidget {
  const EmptyDoctorsView({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84.r,
              height: 84.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenLighter,
              ),
              child: Icon(
                Icons.person_search_outlined,
                size: 42.r,
                color: AppColors.green,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: context.semiBold16Dark,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: context.regular14GreyBlueDark,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              SizedBox(
                height: 40.h,
                child: OutlinedButton(
                  onPressed: onRetry,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.green,
                    side: BorderSide(color: AppColors.green, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      context.t.admin.retry,
                      style: context.medium14Green,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
