import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/doctor_image.dart';

class AppointmentCardHeader extends StatelessWidget {
  const AppointmentCardHeader({
    super.key,
    required this.appointment,
    required this.isPatient,
  });

  final Appointment appointment;
  final bool isPatient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: DoctorImage(
            photo: isPatient
                ? appointment.doctorPhotoUrl
                : appointment.patientPhotoUrl,
            width: 48.w,
            height: 48.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      isPatient
                          ? appointment.doctorName
                          : appointment.patientName,
                      style: context.bold16DarkNavy,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _buildStatusPill(context),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                isPatient
                    ? appointment.doctorSpecialty
                    : context.t.adminAppointments.patientSection,
                style: context.regular12Grey,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusPill(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (appointment.status) {
      case AppointmentStatus.upcoming:
        bgColor = AppColors.green.withValues(alpha: 0.1);
        textColor = AppColors.green;
        text = context.t.adminAppointments.tabUpcoming;
        break;
      case AppointmentStatus.completed:
        bgColor = AppColors.blue.withValues(alpha: 0.1);
        textColor = AppColors.blue;
        text = context.t.adminAppointments.tabCompleted;
        break;
      case AppointmentStatus.cancelled:
        bgColor = AppColors.red.withValues(alpha: 0.1);
        textColor = AppColors.red;
        text = context.t.adminAppointments.tabCancelled;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(text, style: context.semiBold10.copyWith(color: textColor)),
    );
  }
}
