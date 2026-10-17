import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';

void showRateDoctorDialog(
  BuildContext context, {
  required void Function(double rating, String? comment) onSubmit,
}) {
  showDialog(
    context: context,
    builder: (context) => _RateDoctorDialog(onSubmit: onSubmit),
  );
}

class _RateDoctorDialog extends StatefulWidget {
  const _RateDoctorDialog({required this.onSubmit});

  final void Function(double rating, String? comment) onSubmit;

  @override
  State<_RateDoctorDialog> createState() => _RateDoctorDialogState();
}

class _RateDoctorDialogState extends State<_RateDoctorDialog> {
  double _rating = 0;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.t.patientAppointments.rateDoctor,
              style: context.bold20DarkNavy,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              context.t.patientAppointments.tapToRate,
              style: context.regular16Grey,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () => setState(() => _rating = index + 1.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: AppColors.yellow,
                      size: 32.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: context.t.patientAppointments.reviewComment,
                hintStyle: context.regular14Grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.overlayLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.overlayLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.green),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                onPressed: _rating > 0
                    ? () {
                        Navigator.of(context).pop();
                        widget.onSubmit(_rating, _commentController.text.trim());
                      }
                    : null,
                child: Text(
                  context.t.patientAppointments.submitRating,
                  style: context.semiBold16White,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
