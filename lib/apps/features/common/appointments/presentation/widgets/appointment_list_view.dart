import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';
import 'appointment_card.dart';

class AppointmentListView extends StatelessWidget {
  const AppointmentListView({
    super.key,
    required this.appointments,
    required this.isPatient,
    this.onCancel,
    this.onMarkCompleted,
    this.onViewDetails,
    this.onRateDoctor,
    this.onRefresh,
  });

  final List<Appointment> appointments;
  final bool isPatient;
  final void Function(Appointment)? onCancel;
  final void Function(Appointment)? onMarkCompleted;
  final void Function(Appointment)? onViewDetails;
  final void Function(Appointment)? onRateDoctor;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    Widget content;
    
    if (appointments.isEmpty) {
      content = CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Text(
                isPatient
                    ? context.t.patientAppointments.emptyState
                    : context.t.adminAppointments.emptyState,
                style: context.regular16Grey,
              ),
            ),
          ),
        ],
      );
    } else {
      content = ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCard(
            appointment: appointment,
            isPatient: isPatient,
            onCancel: onCancel != null ? () => onCancel!(appointment) : null,
            onMarkCompleted:
                onMarkCompleted != null ? () => onMarkCompleted!(appointment) : null,
            onViewDetails:
                onViewDetails != null ? () => onViewDetails!(appointment) : null,
            onRateDoctor:
                onRateDoctor != null ? () => onRateDoctor!(appointment) : null,
          );
        },
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        color: AppColors.green,
        backgroundColor: AppColors.white,
        child: content,
      );
    }

    return content;
  }
}

