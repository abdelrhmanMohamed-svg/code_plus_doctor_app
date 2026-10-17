import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';

class AppointmentCardRating extends StatelessWidget {
  const AppointmentCardRating({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    if (appointment.rating == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.overlayLight, height: 24.h),
        Row(
          children: [
            Text(context.t.patientAppointments.yourRating, style: context.semiBold12Grey),
            SizedBox(width: 8.w),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < appointment.rating! ? Icons.star : Icons.star_border,
                  color: AppColors.yellow,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
        if (appointment.reviewComment != null &&
            appointment.reviewComment!.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.offWhiteSoft,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.overlayLight),
            ),
            child: Text(
              '"${appointment.reviewComment}"',
              style: context.regular12DarkNavy.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
