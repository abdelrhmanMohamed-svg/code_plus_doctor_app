import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/blurred_blob.dart';
import '../controller/favourite_doctors_cubit.dart';
import '../controller/favourite_doctors_state.dart';
import '../widgets/favourite_doctor_grid_card.dart';
import '../widgets/favourite_doctors_search_bar.dart';

/// Favourite Doctors screen displaying all favorited doctors in a 2-column grid.
class FavouriteDoctorsScreen extends StatelessWidget {
  const FavouriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<FavouriteDoctorsCubit>(
              create: (_) => getIt<FavouriteDoctorsCubit>()..loadDoctors(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                    child: Row(
                      children: [
                        Text(
                          context.t.favouriteDoctors.title,
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
                        return FavouriteDoctorsSearchBar(
                          onChanged: (value) => context
                              .read<FavouriteDoctorsCubit>()
                              .search(value),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: BlocBuilder<
                      FavouriteDoctorsCubit,
                      FavouriteDoctorsState
                    >(
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
                            child: Text(
                              state.errorMessage ?? '',
                              style: context.regular15Grey,
                            ),
                          );
                        }

                        if (state.filteredFavoriteDoctors.isEmpty) {
                          return RefreshIndicator(
                            color: AppColors.green,
                            onRefresh: () => context
                                .read<FavouriteDoctorsCubit>()
                                .loadDoctors(),
                            child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No favourite doctors found.',
                                      style: context.regular15Grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return RefreshIndicator(
                          color: AppColors.green,
                          onRefresh: () => context
                              .read<FavouriteDoctorsCubit>()
                              .loadDoctors(),
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: state.filteredFavoriteDoctors.length,
                            itemBuilder: (context, index) {
                              final doctor =
                                  state.filteredFavoriteDoctors[index];
                              return FavouriteDoctorGridCard(doctor: doctor);
                            },
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
