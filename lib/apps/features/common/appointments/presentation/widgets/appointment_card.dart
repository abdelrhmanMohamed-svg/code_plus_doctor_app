import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';
import 'appointment_card_actions.dart';
import 'appointment_card_details.dart';
import 'appointment_card_header.dart';
import 'appointment_card_rating.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
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
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentCardHeader(appointment: appointment, isPatient: isPatient),
          SizedBox(height: 16.h),
          AppointmentCardDetails(appointment: appointment),
          AppointmentCardRating(appointment: appointment),
          SizedBox(height: 20.h),
          AppointmentCardActions(
            appointment: appointment,
            isPatient: isPatient,
            onCancel: onCancel,
            onViewDetails: onViewDetails,
            onRateDoctor: onRateDoctor,
            onMarkCompleted: onMarkCompleted,
          ),
        ],
      ),
    );
  }
}
