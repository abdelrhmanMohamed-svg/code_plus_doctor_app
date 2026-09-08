import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';

class DoctorStatusBadge extends StatelessWidget {
  const DoctorStatusBadge({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.greenPale : AppColors.greyLighter,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        isActive ? context.t.admin.active : context.t.admin.inactive,
        style: isActive ? context.semiBold10GreenDark : context.semiBold10Grey,
      ),
    );
  }
}
