import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../controller/find_doctor_cubit.dart';
import '../widgets/doctor_card.dart';
import '../widgets/find_doctors_search_bar.dart';

/// Doctors search & listing screen.
class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  List<DoctorCardData> _buildDoctors(BuildContext context) => [
    DoctorCardData(
      id: 'dr-shruti-kedia',
      name: context.t.findDoctors.drShrutiKedia,
      experience: context.t.findDoctors.experience7Years,
      rating: context.t.findDoctors.rating87,
      stories: context.t.findDoctors.stories69,
      availableTime: context.t.findDoctors.timeTen,
      photo: ImageAssets.popularDoctor1,
      favorited: true,
    ),
    DoctorCardData(
      id: 'dr-watamaniuk',
      name: context.t.findDoctors.drWatamaniuk,
      experience: context.t.findDoctors.experience9Years,
      rating: context.t.findDoctors.rating74,
      stories: context.t.findDoctors.stories78,
      availableTime: context.t.findDoctors.timeTwelve,
      photo: ImageAssets.popularDoctor2,
      favorited: false,
    ),
    DoctorCardData(
      id: 'dr-crownover',
      name: context.t.findDoctors.drCrownover,
      experience: context.t.findDoctors.experience5Years,
      rating: context.t.findDoctors.rating59,
      stories: context.t.findDoctors.stories86,
      availableTime: context.t.findDoctors.timeEleven,
      photo: ImageAssets.liveDoctor1,
      favorited: true,
    ),
    DoctorCardData(
      id: 'dr-balestra',
      name: context.t.findDoctors.drBalestra,
      experience: context.t.findDoctors.experience6Years,
      rating: context.t.findDoctors.rating87,
      stories: context.t.findDoctors.stories69,
      availableTime: context.t.findDoctors.timeTen,
      photo: ImageAssets.liveDoctor2,
      favorited: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final doctors = _buildDoctors(context);
    final favoriteIds = doctors
        .where((doctor) => doctor.favorited)
        .map((doctor) => doctor.id);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<FindDoctorCubit>(
              create: (context) =>
                  getIt<FindDoctorCubit>()..setInitialFavorites(favoriteIds),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                    child: Row(
                      children: [
                        _BackButton(onPressed: () => context.pop()),
                        SizedBox(width: 19.w),
                        Text(
                          context.t.findDoctors.title,
                          style: context.semiBold21BlackSoft,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const FindDoctorsSearchBar(),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                      itemCount: doctors.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemBuilder: (context, index) =>
                          DoctorCard(doctor: doctors[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          width: 30.r,
          height: 30.r,
          child: Icon(Icons.chevron_left, size: 18.r, color: AppColors.grey),
        ),
      ),
    );
  }
}
