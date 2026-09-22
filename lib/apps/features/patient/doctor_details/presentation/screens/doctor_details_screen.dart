import 'package:doctor_hunt/apps/core/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/widgets/blurred_blob.dart';
import '../../../../../core/models/doctor.dart';
import '../controller/doctor_details_cubit.dart';
import '../widgets/doctor_details_card.dart';
import '../widgets/doctor_stats_card.dart';
import '../widgets/location_map_card.dart';
import '../widgets/services_section.dart';

/// Doctor Details screen.
class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<DoctorDetailsCubit>(
              create: (context) => getIt<DoctorDetailsCubit>()
                ..setInitialFavorites(
                  doctor.isFavorited ? [doctor.id] : const [],
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                    child: Row(
                      children: [
                        CustomBackButton(onPressed: () => context.pop()),
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
                          Center(child: DoctorDetailsCard(doctor: doctor)),
                          SizedBox(height: 24.h),
                          Center(child: DoctorStatsCard(doctor: doctor)),
                          SizedBox(height: 27.h),
                          ServicesSection(services: doctor.services),
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
