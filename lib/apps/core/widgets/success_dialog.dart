import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../i18n/strings.g.dart';
import '../theme/app_colors.dart';
import '../theme/style_atom.dart';
import '../utils/image_assets.dart';
import 'primary_button.dart';

/// Shows the success / thank-you dialog.
///
/// [title], [subtitle], [message], and [actionLabel] are passed in by the
/// caller so the widget stays reusable beyond the appointment flow.
void showSuccessDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String message,
  required String actionLabel,
  VoidCallback? onAction,
}) {
  showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'success',
    barrierColor: AppColors.dialogScrim,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) => _SuccessDialog(
      title: title,
      subtitle: subtitle,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    ),
  );
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({
    required this.title,
    required this.subtitle,
    required this.message,
    required this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String message;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 335.w,
          height: 520.h,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 156.w,
                height: 156.h,
                decoration: const BoxDecoration(
                  color: AppColors.successCircleBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    ImageAssets.successLike,
                    width: 72.w,
                    height: 69.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(title, style: StyleAtom.thankYouTitle),
              SizedBox(height: 8.h),
              Text(subtitle, style: StyleAtom.thankYouSubtitle),
              SizedBox(height: 16.h),
              Text(
                message,
                style: StyleAtom.thankYouBody,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              PrimaryButton(
                label: context.t.thankYou.doneButton,
                onTap: () {
                  Navigator.of(context).pop();
                  onAction?.call();
                },
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 295.w,
                height: 54.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.inputBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onAction?.call();
                  },
                  child: Text(
                    actionLabel,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                      fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
