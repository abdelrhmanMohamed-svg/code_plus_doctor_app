import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/blurred_blob.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../controller/home_cubit.dart';
import '../controller/home_state.dart';
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
            child: BlocProvider<HomeCubit>(
              create: (_) => getIt<HomeCubit>()..loadDoctors(),
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<HomeCubit>().refresh(),
                      color: AppColors.green,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeaderWithSearchOverlay(),
                            SizedBox(height: 40.h),
                            const LiveDoctorsSection(),
                            SizedBox(height: 30.h),
                            const CategoryTabs(),
                            SizedBox(height: 24.h),
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) =>
                                  _DoctorsSections(state: state),
                            ),
                          ],
                        ),
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

class _DoctorsSections extends StatelessWidget {
  const _DoctorsSections({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.green),
        ),
      );
    }

    if (state.hasError) {
      return _HomeErrorView(
        message: context.resolveAuthCode(state.errorMessage ?? 'generic'),
      );
    }

    if (state.doctors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopularDoctorsSection(doctors: state.doctors),
        SizedBox(height: 30.h),
        FeatureDoctorsSection(doctors: state.doctors),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _HomeErrorView extends StatelessWidget {
  const _HomeErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 48.h),
      child: Column(
        children: [
          Text(
            message,
            style: context.regular14Grey,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          PrimaryButton(
            label: context.t.home.retry,
            width: 160,
            height: 44,
            borderRadius: 22,
            labelStyle: context.medium14White,
            onTap: () => context.read<HomeCubit>().loadDoctors(),
          ),
        ],
      ),
    );
  }
}
