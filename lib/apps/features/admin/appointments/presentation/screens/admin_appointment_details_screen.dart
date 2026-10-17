import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/back_button.dart';
import '../../../../../core/widgets/confirmation_dialog.dart';
import '../../../../../core/widgets/doctor_image.dart';
import '../controller/admin_appointments_cubit.dart';
import '../controller/admin_appointments_state.dart';

class AdminAppointmentDetailsScreen extends StatelessWidget {
  const AdminAppointmentDetailsScreen({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminAppointmentsCubit, AdminAppointmentsState>(
      listenWhen: (previous, current) =>
          previous.appointments != current.appointments,
      listener: (context, state) {
        // Find the updated appointment to check if its status changed
        final updated = state.appointments.cast<Appointment?>().firstWhere(
          (a) => a?.id == appointment.id,
          orElse: () => null,
        );
        if (updated != null && updated.status != appointment.status) {
          // If status changed, pop back
          if (context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.offWhiteSoft,
        appBar: AppBar(
          backgroundColor: AppColors.offWhiteSoft,
          elevation: 0,
          leading: CustomBackButton(
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            context.t.adminAppointments.appointmentDetailsTitle,
            style: context.semiBold24DarkNavy,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                context,
                context.t.adminAppointments.patientSection,
              ),
              SizedBox(height: 12.h),
              _buildPatientCard(context),
              SizedBox(height: 24.h),
              _buildSectionTitle(
                context,
                context.t.adminAppointments.doctorSection,
              ),
              SizedBox(height: 12.h),
              _buildDoctorCard(context),
              SizedBox(height: 24.h),
              _buildSectionTitle(
                context,
                context.t.adminAppointments.appointmentSection,
              ),
              SizedBox(height: 12.h),
              _buildAppointmentInfoCard(context),
            ],
          ),
        ),
        bottomNavigationBar: appointment.status == AppointmentStatus.upcoming
            ? _buildBottomActions(context)
            : null,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: context.semiBold16DarkNavy);
  }

  Widget _buildPatientCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: DoctorImage(
              photo: appointment.patientPhotoUrl,
              width: 56.w,
              height: 56.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.patientName, style: context.bold16DarkNavy),
                SizedBox(height: 4.h),
                Text(appointment.patientEmail, style: context.regular12Grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: DoctorImage(
              photo: appointment.doctorPhotoUrl,
              width: 56.w,
              height: 56.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.doctorName, style: context.bold16DarkNavy),
                SizedBox(height: 4.h),
                Text(appointment.doctorSpecialty, style: context.regular12Grey),
              ],
            ),
          ),
          _buildStatusBadge(context),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
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
        bgColor = AppColors.green.withValues(alpha: 0.1);
        textColor = AppColors.green;
        text = context.t.adminAppointments.tabCompleted;
        break;
      case AppointmentStatus.cancelled:
        bgColor = AppColors.red.withValues(alpha: 0.1);
        textColor = AppColors.red;
        text = context.t.adminAppointments.tabCancelled;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: context.semiBold10.copyWith(color: textColor),
      ),
    );
  }

  Widget _buildAppointmentInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoTile(
                  context,
                  icon: Icons.calendar_today_outlined,
                  title: appointment.date,
                ),
              ),
              Expanded(
                child: _buildInfoTile(
                  context,
                  icon: Icons.access_time,
                  title: appointment.time,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInfoTile(
            context,
            icon: Icons.monetization_on,
            title: appointment.fee,
            subtitle: context.t.admin.consultationFee,
            isFee: true,
          ),
          SizedBox(height: 16.h),
          _buildInfoTile(
            context,
            icon: Icons.location_on_outlined,
            title: appointment.clinicLocation,
            subtitle: context.t.adminAppointments.clinicLocation,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    bool isFee = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: (isFee ? AppColors.green : AppColors.grey).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isFee ? AppColors.green : AppColors.darkNavy,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (subtitle != null) ...[
                Text(subtitle, style: context.regular12Grey),
                SizedBox(height: 2.h),
              ],
              Text(title, style: context.semiBold14DarkNavy),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                onPressed: () {
                  showConfirmationDialog(
                    context,
                    title: context.t.adminAppointments.cancelAppointment,
                    message: context.t.adminAppointments.cancelConfirmation,
                    confirmLabel: context.t.adminAppointments.cancelAppointment,
                    cancelLabel: context.t.common.back,
                    onConfirm: () {
                      context.read<AdminAppointmentsCubit>().updateStatus(
                        appointment.id,
                        AppointmentStatus.cancelled,
                      );
                    },
                  );
                },
                child: Text(
                  context.t.adminAppointments.cancelAppointment,
                  style: context.semiBold16Red,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  elevation: 0,
                ),
                onPressed: () {
                  showConfirmationDialog(
                    context,
                    title: context.t.adminAppointments.markAsCompleted,
                    message: context.t.adminAppointments.completeConfirmation,
                    confirmLabel: context.t.adminAppointments.markAsCompleted,
                    cancelLabel: context.t.admin.cancel,
                    onConfirm: () {
                      context.read<AdminAppointmentsCubit>().updateStatus(
                        appointment.id,
                        AppointmentStatus.completed,
                      );
                    },
                  );
                },
                child: Text(
                  context.t.adminAppointments.markAsCompleted,
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
