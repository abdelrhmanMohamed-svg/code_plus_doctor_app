import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/models/doctor.dart';

/// Three-column stats bar (Running / Ongoing / Patient) on the
/// Doctor Details screen.
class DoctorStatsCard extends StatelessWidget {
  const DoctorStatsCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          _StatBox(
            value: doctor.runningAppointments.toString(),
            label: context.t.doctorDetails.statsRunning,
          ),
          SizedBox(width: 8.w),
          _StatBox(
            value: doctor.ongoingAppointments.toString(),
            label: context.t.doctorDetails.statsOngoing,
          ),
          SizedBox(width: 8.w),
          _StatBox(
            value: doctor.patients.toString(),
            label: context.t.doctorDetails.statsPatient,
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: AppColors.greyMedium.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: context.medium18Dark),
            SizedBox(height: 3.h),
            Text(label, style: context.regular13Grey),
          ],
        ),
      ),
    );
  }
}
