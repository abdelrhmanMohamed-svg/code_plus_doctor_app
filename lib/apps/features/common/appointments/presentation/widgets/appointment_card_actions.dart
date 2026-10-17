import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';

class AppointmentCardActions extends StatelessWidget {
  const AppointmentCardActions({
    super.key,
    required this.appointment,
    required this.isPatient,
    this.onCancel,
    this.onViewDetails,
    this.onRateDoctor,
    this.onMarkCompleted,
  });

  final Appointment appointment;
  final bool isPatient;
  final VoidCallback? onCancel;
  final VoidCallback? onViewDetails;
  final VoidCallback? onRateDoctor;
  final VoidCallback? onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    if (appointment.status == AppointmentStatus.upcoming) {
      if (isPatient) {
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                ),
                onPressed: onViewDetails,
                child: Text(
                  context.t.patientAppointments.viewDetails,
                  style: context.semiBold14Green,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                ),
                onPressed: onCancel,
                child: Text(
                  context.t.admin.cancel,
                  style: context.semiBold14Red,
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                ),
                onPressed: onCancel,
                child: Text(
                  context.t.admin.cancel,
                  style: context.semiBold14Red,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  elevation: 0,
                ),
                onPressed: onMarkCompleted,
                child: Text(
                  context.t.adminAppointments.markAsCompleted,
                  style: context.semiBold14White,
                ),
              ),
            ),
          ],
        );
      }
    }

    if (appointment.status == AppointmentStatus.completed &&
        isPatient &&
        appointment.rating == null) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w,
                ),
              ),
              onPressed: onViewDetails,
              child: Text(
                context.t.patientAppointments.viewDetails,
                style: context.semiBold14Green,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w,
                ),
                elevation: 0,
              ),
              onPressed: onRateDoctor,
              child: Text(
                context.t.patientAppointments.rateDoctor,
                style: context.semiBold14White,
              ),
            ),
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.green),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
        ),
        onPressed: onViewDetails,
        child: Text(
          isPatient
              ? context.t.patientAppointments.viewDetails
              : context.t.adminAppointments.viewDetails,
          style: context.semiBold14Green,
        ),
      ),
    );
  }
}
