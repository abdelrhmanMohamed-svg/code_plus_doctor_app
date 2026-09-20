import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';
import 'primary_button.dart';

/// Shows a destructive-action confirmation dialog.
///
/// [title], [message], [confirmLabel], and [cancelLabel] are passed in by the
/// caller so the widget stays reusable. [onConfirm] runs after the dialog
/// closes itself.
void showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  required VoidCallback onConfirm,
}) {
  showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'confirmation',
    barrierColor: AppColors.overlayDark,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) => _ConfirmationDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: onConfirm,
    ),
  );
}

class _ConfirmationDialog extends StatelessWidget {
  const _ConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 335.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: context.bold18DarkNavy),
              SizedBox(height: 12.h),
              Text(
                message,
                style: context.regular14Grey,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              PrimaryButton(
                label: confirmLabel,
                color: AppColors.red,
                onTap: () {
                  context.pop();
                  onConfirm();
                },
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 295.w,
                height: 54.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.greyBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => context.pop(),
                  child: Text(cancelLabel, style: context.semiBold16GreyBlueDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}