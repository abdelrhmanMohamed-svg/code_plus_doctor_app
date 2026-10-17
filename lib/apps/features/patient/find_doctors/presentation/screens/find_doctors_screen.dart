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
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../controller/find_doctor_cubit.dart';
import '../controller/find_doctor_state.dart';
import '../widgets/doctor_card.dart';
import '../widgets/find_doctors_search_bar.dart';
import '../widgets/find_doctors_filter_chips.dart';

/// Doctors search & listing screen.
class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<FindDoctorCubit>(
              create: (context) => getIt<FindDoctorCubit>()..loadDoctors(),
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
                          context.t.findDoctors.title,
                          style: context.semiBold21BlackSoft,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Builder(
                      builder: (context) {
                        return FindDoctorsSearchBar(
                          onChanged: (value) =>
                              context.read<FindDoctorCubit>().search(value),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<FindDoctorCubit, FindDoctorState>(
                    buildWhen: (prev, curr) =>
                        prev.filterSpecialty != curr.filterSpecialty,
                    builder: (context, state) {
                      return FindDoctorsFilterChips(
                        selectedSpecialty: state.filterSpecialty,
                        onSelected: (specialty) => context
                            .read<FindDoctorCubit>()
                            .setSpecialtyFilter(specialty),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: BlocBuilder<FindDoctorCubit, FindDoctorState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          );
                        }

                        if (state.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.resolveAuthCode(
                                    state.errorMessage ?? 'generic',
                                  ),
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
                                  onTap: () => context
                                      .read<FindDoctorCubit>()
                                      .loadDoctors(),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state.filteredDoctors.isEmpty) {
                          return Center(
                            child: Text(
                              context.t.findDoctors.noResults,
                              style: context.regular15Grey,
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                          itemCount: state.filteredDoctors.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) => DoctorCard(
                            doctor: state.filteredDoctors[index],
                          ),
                        );
                      },
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
