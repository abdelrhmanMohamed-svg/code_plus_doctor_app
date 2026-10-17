import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/doctor_image.dart';

class PatientAppointmentDetailsScreen extends StatelessWidget {
  const PatientAppointmentDetailsScreen({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkNavy),
        title: Text(
          context.t.adminAppointments.appointmentDetailsTitle,
          style: context.bold20DarkNavy,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, context.t.adminAppointments.doctorSection),
            _buildDoctorCard(context),
            SizedBox(height: 24.h),
            _buildSectionTitle(context, context.t.adminAppointments.appointmentSection),
            _buildAppointmentDetailsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Text(title, style: context.bold18DarkNavy),
    );
  }

  Widget _buildDoctorCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: DoctorImage(
              photo: appointment.doctorPhotoUrl,
              width: 60.w,
              height: 60.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.doctorName, style: context.bold16DarkNavy),
                SizedBox(height: 4.h),
                Text(appointment.doctorSpecialty, style: context.regular14Grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetailsCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(context, Icons.calendar_today, context.t.patientAppointments.dateLabel, appointment.date),
          _buildDivider(),
          _buildDetailRow(context, Icons.access_time, context.t.patientAppointments.timeLabel, appointment.time),
          _buildDivider(),
          _buildDetailRow(context, Icons.monetization_on, context.t.patientAppointments.feeLabel, appointment.fee, isFee: true),
          _buildDivider(),
          _buildDetailRow(context, Icons.location_on, context.t.patientAppointments.clinicLocation, appointment.clinicLocation),
          _buildDivider(),
          _buildDetailRow(context, Icons.info_outline, context.t.patientAppointments.statusLabel, appointment.status.name.toUpperCase()),
          if (appointment.rating != null) ...[
            _buildDivider(),
            _buildDetailRow(context, Icons.star, context.t.patientAppointments.ratingLabel, '${appointment.rating} / 5.0'),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value, {bool isFee = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.green, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Text(label, style: context.regular14Grey),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: isFee ? context.bold14Green : context.semiBold14DarkNavy,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppColors.overlayLight,
      height: 16.h,
      thickness: 1,
    );
  }
}
