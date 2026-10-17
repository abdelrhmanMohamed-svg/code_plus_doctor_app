import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';

class NoSlotsView extends StatelessWidget {
  const NoSlotsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40.h),
        Icon(
          Icons.event_busy,
          size: 100.r,
          color: AppColors.blueBright,
        ),
        SizedBox(height: 20.h),
        Text(
          context.t.appointmentBooking.noSlotsAvailable,
          style: context.medium16Dark,
        ),
      ],
    );
  }
}
