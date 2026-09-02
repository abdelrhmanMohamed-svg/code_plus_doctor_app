import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controller/find_doctor_cubit.dart';
import '../controller/find_doctor_state.dart';

/// Search result card within the Find Doctors list.
class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final DoctorCardData doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 17.h, 17.w, 17.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.asset(
                  doctor.photo,
                  width: 92.w,
                  height: 87.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: context.medium21Dark,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      context.t.findDoctors.toothsDentist,
                      style: context.regular17Green,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      doctor.experience,
                      style: context.regular14Grey,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        _RatingDot(),
                        SizedBox(width: 8.w),
                        Text(doctor.rating, style: context.regular13Grey),
                        SizedBox(width: 8.w),
                        _RatingDot(),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            doctor.stories,
                            style: context.regular13Grey,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              BlocBuilder<FindDoctorCubit, FindDoctorState>(
                builder: (context, state) => GestureDetector(
                  onTap: () =>
                      context.read<FindDoctorCubit>().toggleFavorite(doctor.id),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Icon(
                      state.isFavorited(doctor.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 19.r,
                      color: state.isFavorited(doctor.id)
                          ? AppColors.red
                          : AppColors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 19.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.findDoctors.nextAvailable,
                    style: context.regular15Green,
                  ),
                  SizedBox(height: 7.h),
                  Text(doctor.availableTime, style: context.regular14Grey),
                ],
              ),
              const Spacer(),
              PrimaryButton(
                label: context.t.findDoctors.bookNow,
                width: 112,
                height: 34,
                borderRadius: 4,
                labelStyle: context.medium14White,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Static data backing a [DoctorCard].
class DoctorCardData {
  const DoctorCardData({
    required this.id,
    required this.name,
    required this.experience,
    required this.rating,
    required this.stories,
    required this.availableTime,
    required this.photo,
    required this.favorited,
  });

  final String id;
  final String name;
  final String experience;
  final String rating;
  final String stories;
  final String availableTime;
  final String photo;
  final bool favorited;
}

class _RatingDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.r,
      height: 10.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.green,
      ),
    );
  }
}
