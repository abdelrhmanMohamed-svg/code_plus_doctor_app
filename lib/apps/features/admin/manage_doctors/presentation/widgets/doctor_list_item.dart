import 'package:doctor_hunt/apps/core/widgets/doctor_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/theme/app_colors.dart';
import 'doctor_status_badge.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: DoctorImage(
                photo: doctor.photo,
                width: 72.r,
                height: 72.r,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.name,
                          style: context.semiBold16Dark,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DoctorStatusBadge(isActive: doctor.isActive),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(doctor.specialty, style: context.regular13GreyBlueDark),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < doctor.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            size: 14.r,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${doctor.rating.toStringAsFixed(1)} · ${context.t.admin.reviewsCount(count: doctor.reviewsCount)}',
                        style: context.regular12GreyBlueDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
