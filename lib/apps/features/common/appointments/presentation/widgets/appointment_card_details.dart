import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/theme/app_colors.dart';

class AppointmentCardDetails extends StatelessWidget {
  const AppointmentCardDetails({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconText(
          context,
          Icons.calendar_today_outlined,
          appointment.date,
        ),
        SizedBox(width: 16.w),
        _buildIconText(context, Icons.access_time, appointment.time),
        SizedBox(width: 16.w),
        _buildIconText(
          context,
          Icons.monetization_on,
          appointment.fee,
          isFee: true,
        ),
      ],
    );
  }

  Widget _buildIconText(
    BuildContext context,
    IconData icon,
    String text, {
    bool isFee = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: isFee ? AppColors.green : AppColors.grey,
        ),
        SizedBox(width: 4.w),
        Text(text, style: context.semiBold12DarkNavy),
      ],
    );
  }
}
