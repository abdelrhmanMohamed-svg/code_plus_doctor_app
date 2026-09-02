import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/utils/image_assets.dart';
import 'home_section_title.dart';

/// Horizontal scroll of popular doctor cards.
class PopularDoctorsSection extends StatelessWidget {
  const PopularDoctorsSection({super.key});

  List<_PopularDoctor> _buildDoctors(BuildContext context) => [
    _PopularDoctor(
      context.t.doctorData.drBlessing,
      context.t.doctorData.drBlessingSpecialty,
      ImageAssets.popularDoctor1,
    ),
    _PopularDoctor(
      context.t.doctorData.drFillerupGrab,
      context.t.doctorData.drFillerupGrabSpecialty,
      ImageAssets.popularDoctor2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final doctors = _buildDoctors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionTitle(title: context.t.home.popularDoctor),
        SizedBox(height: 22.h),
        SizedBox(
          height: 264.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: doctors.length,
            separatorBuilder: (context, index) => SizedBox(width: 15.w),
            itemBuilder: (context, index) =>
                _PopularDoctorCard(doctor: doctors[index]),
          ),
        ),
      ],
    );
  }
}

class _PopularDoctor {
  const _PopularDoctor(this.name, this.specialty, this.photo);

  final String name;
  final String specialty;
  final String photo;
}

class _PopularDoctorCard extends StatelessWidget {
  const _PopularDoctorCard({required this.doctor});

  static const int _ratingStars = 5;
  static const int _filledStars = 4;

  final _PopularDoctor doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.doctorDetails),
      child: Container(
        width: 190.w,
        height: 264.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayLight,
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.r),
                bottom: Radius.circular(2.r),
              ),
              child: Image.asset(
                doctor.photo,
                width: 190.w,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      doctor.name,
                      style: context.medium18Dark,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      doctor.specialty,
                      style: context.regular12Grey,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _ratingStars,
                        (index) => Icon(
                          Icons.star,
                          size: 13.r,
                          color: index < _filledStars
                              ? AppColors.yellowWarm
                              : AppColors.greyLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
