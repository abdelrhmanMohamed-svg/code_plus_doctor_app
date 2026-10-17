import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/cancelling_dialog.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../common/appointments/presentation/widgets/appointment_list_view.dart';
import '../controller/patient_appointments_cubit.dart';
import '../controller/patient_appointments_state.dart';
import '../widgets/rate_doctor_dialog.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PatientAppointmentsCubit>()..loadAppointments(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.offWhiteSoft,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              context.t.tabs.appointments,
              style: context.bold20DarkNavy,
            ),
          ),
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
                    Tab(text: context.t.patientAppointments.tabUpcoming),
                    Tab(text: context.t.patientAppointments.tabCompleted),
                    Tab(text: context.t.patientAppointments.tabCancelled),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<PatientAppointmentsCubit, PatientAppointmentsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.green),
                      );
                    }

                    if (state.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.resolveAuthCode(state.errorMessage ?? 'generic'),
                              style: context.regular16Grey,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.h),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<PatientAppointmentsCubit>().loadAppointments(),
                              child: Text(context.t.home.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    final cubit = context.read<PatientAppointmentsCubit>();
                    return TabBarView(
                      children: [
                        AppointmentListView(
                          appointments: state.upcoming,
                          isPatient: true,
                          onCancel: (appointment) => _confirmCancel(context, appointment, cubit),
                          onViewDetails: (appointment) =>
                              context.push(AppRouter.patientAppointmentDetails, extra: appointment),
                          onRefresh: () async => cubit.loadAppointments(),
                        ),
                        AppointmentListView(
                          appointments: state.completed,
                          isPatient: true,
                          onRateDoctor: (appointment) => _rateDoctor(context, appointment, cubit),
                          onViewDetails: (appointment) =>
                              context.push(AppRouter.patientAppointmentDetails, extra: appointment),
                          onRefresh: () async => cubit.loadAppointments(),
                        ),
                        AppointmentListView(
                          appointments: state.cancelled,
                          isPatient: true,
                          onViewDetails: (appointment) =>
                              context.push(AppRouter.patientAppointmentDetails, extra: appointment),
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
      BuildContext context, Appointment appointment, PatientAppointmentsCubit cubit) {
    showCancellingDialog(
      context,
      title: context.t.patientAppointments.cancelAppointment,
      message: context.t.patientAppointments.cancelConfirmation,
      confirmLabel: context.t.admin.cancel,
      cancelLabel: context.t.common.back,
      onConfirm: () {
        cubit.cancelAppointment(appointment.id);
      },
    );
  }

  void _rateDoctor(
      BuildContext context, Appointment appointment, PatientAppointmentsCubit cubit) {
    showRateDoctorDialog(
      context,
      onSubmit: (rating, comment) {
        cubit.submitRating(appointment.id, appointment.doctorId, rating, comment);
      },
    );
  }
}
