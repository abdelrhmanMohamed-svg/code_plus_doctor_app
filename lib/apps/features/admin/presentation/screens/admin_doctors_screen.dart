import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extensions/error_mapper.dart';
import '../../../../core/extensions/snackbar_context.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/admin_cubit.dart';
import '../controller/admin_state.dart';
import '../widgets/doctor_list_item.dart';
import '../widgets/doctor_search_bar.dart';
import '../widgets/doctor_stats_card.dart';
import '../widgets/doctors_app_bar.dart';
import '../widgets/empty_doctors_view.dart';
import '../widgets/specialty_filter_sheet.dart';

class AdminDoctorsScreen extends StatelessWidget {
  const AdminDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdminCubit>()..loadDoctors(),
      child: const _AdminDoctorsView(),
    );
  }
}

class _AdminDoctorsView extends StatelessWidget {
  const _AdminDoctorsView();

  Future<void> _openCreateDoctor(BuildContext context) async {
    final cubit = context.read<AdminCubit>();
    final created = await context.push<bool>(AppRouter.createDoctor);
    if (created == true && context.mounted) cubit.loadDoctors();
  }

  Future<void> _openFilter(BuildContext context) async {
    final cubit = context.read<AdminCubit>();
    final selected = await showSpecialtyFilterSheet(
      context,
      current: cubit.state.filterSpecialty,
    );
    if (!context.mounted) return;
    cubit.setSpecialtyFilter(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      body: BlocListener<AdminCubit, AdminState>(
        listenWhen: (prev, curr) => !prev.hasError && curr.hasError,
        listener: (context, state) {
          context.showErrorSnackBar(
            state.errorMessage == null
                ? context.t.admin.loadFailureMessage
                : context.resolveAuthCode(state.errorMessage!),
          );
        },
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return Column(
              children: [
                DoctorsAppBar(
                  title: context.t.admin.doctorsTitle,
                  leading: Icon(Icons.menu, color: AppColors.white, size: 24.r),
                  trailing: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.white,
                    size: 24.r,
                  ),
                ),
                SizedBox(height: 16.h),
                DoctorSearchBar(
                  onChanged: (query) =>
                      context.read<AdminCubit>().search(query),
                  onFilterTap: () => _openFilter(context),
                ),
                SizedBox(height: 16.h),
                DoctorStatsCard(
                  totalDoctors: state.totalDoctors,
                  activeDoctors: state.activeDoctors,
                ),
                SizedBox(height: 16.h),
                Expanded(child: _buildBody(context, state)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateDoctor(context),
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        icon: Icon(Icons.add, size: 20.r),
        label: Text(context.t.admin.addDoctor, style: context.medium14White),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody(BuildContext context, AdminState state) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.green));
    }

    if (state.hasError) {
      return EmptyDoctorsView(
        title: context.t.admin.loadFailureMessage,
        message: context.t.admin.emptyStateMessage,
        onRetry: () => context.read<AdminCubit>().loadDoctors(),
      );
    }

    if (state.doctors.isEmpty) {
      return EmptyDoctorsView(
        title: state.hasActiveFilter
            ? context.t.admin.noResultsTitle
            : context.t.admin.emptyStateTitle,
        message: state.hasActiveFilter
            ? context.t.admin.noResultsMessage
            : context.t.admin.emptyStateMessage,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 120.h),
      itemCount: state.doctors.length,
      itemBuilder: (context, index) {
        final doctor = state.doctors[index];
        return DoctorListItem(doctor: doctor);
      },
    );
  }
}
