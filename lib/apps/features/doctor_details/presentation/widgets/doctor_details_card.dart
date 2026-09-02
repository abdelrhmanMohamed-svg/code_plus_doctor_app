import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/models/doctor_model.dart';
import '../controller/doctor_details_cubit.dart';
import '../controller/doctor_details_state.dart';

/// Doctor summary card shown at the top of the Doctor Details screen.
class DoctorDetailsCard extends StatelessWidget {
  const DoctorDetailsCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      padding: EdgeInsets.fromLTRB(19.w, 18.h, 16.w, 16.h),
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
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  doctor.photo,
                  width: 92.w,
                  height: 87.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doctor.name,
                            style: context.medium18Dark,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
                          builder: (context, state) => GestureDetector(
                            onTap: () => context
                                .read<DoctorDetailsCubit>()
                                .toggleFavorite(doctor.id),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: Icon(
                                state.isFavorited(doctor.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 19.r,
                                color: state.isFavorited(doctor.id)
                                    ? AppColors.redBright
                                    : AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      doctor.specialty,
                      style: context.light14Grey,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        _StarRating(rating: doctor.rating),
                        RichText(
                          text: TextSpan(
                            text: "\$ ",
                            style: context.medium16Dark.copyWith(
                              color: AppColors.green,
                            ),
                            children: [
                              TextSpan(
                                text: doctor.price,
                                style: context.medium16Dark,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          PrimaryButton(
            label: context.t.findDoctors.bookNow,
            onTap: () => context.push(AppRouter.appointmentBooking),
            width: 140,
            height: 32,
            borderRadius: 4,
            labelStyle: context.medium14White,
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating});

  static const int _ratingStars = 5;

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _ratingStars,
        (index) => Icon(
          Icons.star,
          size: 13.r,
          color: index < rating.round()
              ? AppColors.yellowWarm
              : AppColors.greyLight,
        ),
      ),
    );
  }
}
