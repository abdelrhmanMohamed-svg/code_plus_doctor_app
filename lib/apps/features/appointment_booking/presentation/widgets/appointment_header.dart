import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';

/// Header row with a back button and "Appointment" title.
class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back_ios, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Text(context.t.appointmentBooking.title, style: context.bold18Dark),
        ],
      ),
    );
  }
}
