import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/utils/image_assets.dart';
import 'home_section_title.dart';

/// Horizontal scroll of compact featured-doctor cards.
class FeatureDoctorsSection extends StatelessWidget {
  const FeatureDoctorsSection({super.key});

  List<_FeatureDoctor> _buildDoctors(BuildContext context) => [
    _FeatureDoctor(
      context.t.doctorData.drCrick,
      context.t.doctorData.priceCrick,
      '3.7',
    ),
    _FeatureDoctor(
      context.t.doctorData.drStrain,
      context.t.doctorData.priceStrain,
      '3.0',
    ),
    _FeatureDoctor(
      context.t.doctorData.drLachinet,
      context.t.doctorData.priceLachinet,
      '2.9',
    ),
    _FeatureDoctor(
      context.t.doctorData.drCrick,
      context.t.doctorData.priceCrick,
      '3.0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final doctors = _buildDoctors(context);
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

class _FeatureDoctor {
  const _FeatureDoctor(this.name, this.price, this.rating);

  final String name;
  final String price;
  final String rating;
}

class _FeatureDoctorCard extends StatelessWidget {
  const _FeatureDoctorCard({required this.doctor});

  final _FeatureDoctor doctor;

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
              ImageAssets.homeProfile,
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
              Text(doctor.rating, style: context.regular10Grey),
            ],
          ),
        ],
      ),
    );
  }
}
