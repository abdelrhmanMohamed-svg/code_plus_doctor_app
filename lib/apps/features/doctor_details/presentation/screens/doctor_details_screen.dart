import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/models/doctor.dart';
import '../controller/doctor_details_cubit.dart';
import '../widgets/doctor_details_card.dart';
import '../widgets/doctor_stats_card.dart';
import '../widgets/location_map_card.dart';
import '../widgets/services_section.dart';

/// Doctor Details screen.
class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, this.doctor});

  final Doctor? doctor;

  @override
  Widget build(BuildContext context) {
    final data = doctor ?? Doctor.dummyDoctors.first;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<DoctorDetailsCubit>(
              create: (context) => getIt<DoctorDetailsCubit>()
                ..setInitialFavorites(data.isFavorited ? [data.id] : const []),
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
                          context.t.doctorDetails.title,
                          style: context.medium18Dark,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: DoctorDetailsCard(doctor: data)),
                          SizedBox(height: 24.h),
                          Center(child: DoctorStatsCard(doctor: data)),
                          SizedBox(height: 27.h),
                          ServicesSection(services: data.services),
                          SizedBox(height: 30.h),
                          const Center(child: LocationMapCard()),
                        ],
                      ),
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
