import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
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
                            style: StyleAtom.doctorDetailsName,
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
                                    ? AppColors.likeHeartRed
                                    : AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      doctor.specialty,
                      style: StyleAtom.doctorDetailsSpecialty,
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
                            style: StyleAtom.doctorDetailsPrice.copyWith(
                              color: AppColors.primary,
                            ),
                            children: [
                              TextSpan(
                                text: doctor.price,
                                style: StyleAtom.doctorDetailsPrice,
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
          Container(
            width: 140.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              context.t.findDoctors.bookNow,
              style: StyleAtom.findDoctorBookNow,
            ),
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
              ? AppColors.starFilled
              : AppColors.starInactive,
        ),
      ),
    );
  }
}
