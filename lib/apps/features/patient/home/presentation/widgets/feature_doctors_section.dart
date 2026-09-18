import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/theme/app_colors.dart';
import 'home_section_title.dart';

/// Horizontal scroll of compact featured-doctor cards.
class FeatureDoctorsSection extends StatelessWidget {
  const FeatureDoctorsSection({super.key, required this.doctors});

  final List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionTitle(title: context.t.home.featureDoctor),
        SizedBox(height: 20.h),
        SizedBox(
          height: 130.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: doctors.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) =>
                _FeatureDoctorCard(doctor: doctors[index]),
          ),
        ),
      ],
    );
  }
}

class _FeatureDoctorCard extends StatelessWidget {
  const _FeatureDoctorCard({required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              doctor.photo,
              width: 54.r,
              height: 54.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            doctor.name,
            style: context.medium12Dark,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(doctor.price, style: context.regular9GreenMint),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 10.r, color: AppColors.yellowWarm),
              SizedBox(width: 2.w),
              Text(
                doctor.rating.toStringAsFixed(1),
                style: context.regular10Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
