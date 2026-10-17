import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controller/manage_doctors_cubit.dart';
import '../controller/manage_doctors_state.dart';
import '../widgets/doctor_list_item.dart';
import '../widgets/doctor_search_bar.dart';
import '../widgets/doctor_stats_card.dart';
import '../widgets/empty_doctors_view.dart';
import '../widgets/specialty_filter_chips.dart';
import '../../../shell/presentation/widgets/admin_app_bar.dart';

class ManageDoctorsScreen extends StatelessWidget {
  const ManageDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ManageDoctorsCubit>()..loadDoctors(),
      child: const _ManageDoctorsView(),
    );
  }
}

class _ManageDoctorsView extends StatelessWidget {
  const _ManageDoctorsView();

  Future<void> _openCreateDoctor(BuildContext context) async {
    final cubit = context.read<ManageDoctorsCubit>();
    await context.push(AppRouter.createDoctor, extra: (cubit, null as Doctor?));
  }

  Future<void> _openDoctorDetails(BuildContext context, Doctor doctor) async {
    final cubit = context.read<ManageDoctorsCubit>();
    await context.push(AppRouter.adminDoctorDetails, extra: (cubit, doctor));
  }



  // Bottom sheet filter removed, using inline chips now.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      appBar: AdminAppBar(title: context.t.admin.doctorsTitle),
      body: BlocListener<ManageDoctorsCubit, ManageDoctorsState>(
        listenWhen: (prev, curr) =>
            (!prev.hasError && curr.hasError) ||
            (prev.errorMessage != curr.errorMessage &&
                curr.formStatus == DoctorFormStatus.initial),
        listener: (context, state) {
          if (state.hasError) {
            context.showErrorSnackBar(
              state.errorMessage == null
                  ? context.t.admin.loadFailureMessage
                  : context.resolveAuthCode(state.errorMessage!),
            );
            return;
          }
          if (state.errorMessage != null) {
            context.showErrorSnackBar(
              context.resolveAuthCode(state.errorMessage!),
            );
          }
        },
        child: BlocBuilder<ManageDoctorsCubit, ManageDoctorsState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  DoctorStatsCard(
                    totalDoctors: state.totalDoctors,
                    activeDoctors: state.activeDoctors,
                  ),
                  SizedBox(height: 16.h),
                  DoctorSearchBar(
                    onChanged: (query) =>
                        context.read<ManageDoctorsCubit>().search(query),
                  ),
                  SizedBox(height: 16.h),
                  SpecialtyFilterChips(
                    selectedSpecialty: state.filterSpecialty,
                    onSelected: (specialty) => context
                        .read<ManageDoctorsCubit>()
                        .setSpecialtyFilter(specialty),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(child: _buildBody(context, state)),
                ],
              ),
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

  Widget _buildBody(BuildContext context, ManageDoctorsState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.green),
      );
    }

    if (state.hasError) {
      return EmptyDoctorsView(
        title: context.t.admin.loadFailureMessage,
        message: context.t.admin.emptyStateMessage,
        onRetry: () => context.read<ManageDoctorsCubit>().loadDoctors(),
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
        return DoctorListItem(
          doctor: doctor,
          onTap: () => _openDoctorDetails(context, doctor),
        );
      },
    );
  }
}
