import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../profile/presentation/controller/user_cubit.dart';
import '../widgets/category_tabs.dart';
import '../widgets/feature_doctors_section.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/live_doctors_section.dart';
import '../widgets/popular_doctors_section.dart';
import '../widgets/profile_header.dart';

/// Main scrollable home screen with all marketplace sections.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderWithSearchOverlay(),
                        SizedBox(height: 40.h),
                        const LiveDoctorsSection(),
                        SizedBox(height: 30.h),
                        const CategoryTabs(),
                        SizedBox(height: 24.h),
                        const PopularDoctorsSection(),
                        SizedBox(height: 30.h),
                        const FeatureDoctorsSection(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithSearchOverlay() {
    return SizedBox(
      height: 180.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: BlocProvider(
              create: (_) => getIt<UserCubit>(),
              child: const ProfileHeader(),
            ),
          ),
          Positioned(
            top: 150.h,
            left: 20.w,
            right: 20.w,
            child: const HomeSearchBar(),
          ),
        ],
      ),
    );
  }
}
