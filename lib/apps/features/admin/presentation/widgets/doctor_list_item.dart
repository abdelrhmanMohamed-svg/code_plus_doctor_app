import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/doctor.dart';
import 'doctor_status_badge.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({super.key, required this.doctor, this.onMenuTap});

  final Doctor doctor;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.greyBorder, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenLighter,
              image: DecorationImage(image: AssetImage(doctor.photo)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: context.semiBold14Dark),
                SizedBox(height: 2.h),
                Text(doctor.specialty, style: context.regular12GreyBlueDark),
                SizedBox(height: 4.h),
                DoctorStatusBadge(isActive: doctor.isActive),
              ],
            ),
          ),
          GestureDetector(
            onTap: onMenuTap,
            child: Icon(
              Icons.more_vert,
              color: AppColors.greyBlueDark,
              size: 20.r,
            ),
          ),
        ],
      ),
    );
  }
}
