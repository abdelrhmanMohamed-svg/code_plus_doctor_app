import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/theme/app_colors.dart';
import 'doctor_status_badge.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({
    super.key,
    required this.doctor,
    this.onEdit,
    this.onDelete,
  });

  final Doctor doctor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
            width: 48.r,
            height: 48.r,
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
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.greyBlueDark,
              size: 20.r,
            ),
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  onEdit?.call();
                  break;
                case 'delete':
                  onDelete?.call();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text(
                  context.t.admin.editDoctor,
                  style: context.regular14Dark,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  context.t.admin.deleteDoctor,
                  style: context.regular14Dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
