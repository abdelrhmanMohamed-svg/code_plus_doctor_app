import 'package:doctor_hunt/apps/core/models/appointment.dart';
import 'package:doctor_hunt/apps/features/admin/shell/presentation/widgets/admin_app_bar.dart';
import 'package:doctor_hunt/apps/features/common/appointments/presentation/widgets/appointment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controller/admin_appointments_cubit.dart';
import '../controller/admin_appointments_state.dart';
import '../../../../../core/widgets/confirmation_dialog.dart';
import '../../../../../core/router/app_router.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdminAppointmentsCubit>()..loadAppointments(),
      child:      DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.offWhiteSoft,
          appBar: AdminAppBar(title: context.t.admin.appointmentsTitle),
          body: Column(
            children: [
              Container(
                height: 48.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.green,
                  labelStyle: context.semiBold14White,
                  unselectedLabelStyle: context.semiBold14Green,
                  tabs: [
                    Tab(text: context.t.admin.filterAll),
                    Tab(text: context.t.adminAppointments.tabUpcoming),
                    Tab(text: context.t.adminAppointments.tabCompleted),
                    Tab(text: context.t.adminAppointments.tabCancelled),
                  ],
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<AdminAppointmentsCubit, AdminAppointmentsState>(
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
                                  style: context.regular16Grey,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 12.h),
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<AdminAppointmentsCubit>()
                                      .loadAppointments(),
                                  child: Text(context.t.admin.retry),
                                ),
                              ],
                            ),
                          );
                        }

                        final cubit = context.read<AdminAppointmentsCubit>();
                        return TabBarView(
                          children: [
                            AppointmentListView(
                              appointments: state.appointments,
                              isPatient: false,
                              onCancel: (appointment) =>
                                  _confirmCancel(context, appointment, cubit),
                              onMarkCompleted: (appointment) =>
                                  _confirmComplete(context, appointment, cubit),
                              onViewDetails: (appointment) => context.push(
                                AppRouter.adminAppointmentDetails,
                                extra: (cubit, appointment),
                              ),
                              onRefresh: () async => cubit.loadAppointments(),
                            ),
                            AppointmentListView(
                              appointments: state.upcoming,
                              isPatient: false,
                              onCancel: (appointment) =>
                                  _confirmCancel(context, appointment, cubit),
                              onMarkCompleted: (appointment) =>
                                  _confirmComplete(context, appointment, cubit),
                              onViewDetails: (appointment) => context.push(
                                AppRouter.adminAppointmentDetails,
                                extra: (cubit, appointment),
                              ),
                              onRefresh: () async => cubit.loadAppointments(),
                            ),
                            AppointmentListView(
                              appointments: state.completed,
                              isPatient: false,
                              onViewDetails: (appointment) => context.push(
                                AppRouter.adminAppointmentDetails,
                                extra: (cubit, appointment),
                              ),
                              onRefresh: () async => cubit.loadAppointments(),
                            ),
                            AppointmentListView(
                              appointments: state.cancelled,
                              isPatient: false,
                              onViewDetails: (appointment) => context.push(
                                AppRouter.adminAppointmentDetails,
                                extra: (cubit, appointment),
                              ),
                              onRefresh: () async => cubit.loadAppointments(),
                            ),
                          ],
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmCancel(
    BuildContext context,
    Appointment appointment,
    AdminAppointmentsCubit cubit,
  ) {
    showConfirmationDialog(
      context,
      title: context.t.adminAppointments.cancelAppointment,
      message: context.t.adminAppointments.cancelConfirmation,
      confirmLabel: context.t.adminAppointments.cancelAppointment,
      cancelLabel: context.t.common.back,
      onConfirm: () {
        cubit.updateStatus(appointment.id, AppointmentStatus.cancelled);
      },
    );
  }

  void _confirmComplete(
    BuildContext context,
    Appointment appointment,
    AdminAppointmentsCubit cubit,
  ) {
    showConfirmationDialog(
      context,
      title: context.t.adminAppointments.markAsCompleted,
      message: context.t.adminAppointments.completeConfirmation,
      confirmLabel: context.t.adminAppointments.markAsCompleted,
      cancelLabel: context.t.admin.cancel,
      onConfirm: () {
        cubit.updateStatus(appointment.id, AppointmentStatus.completed);
      },
    );
  }
}
