import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controller/manage_doctors_cubit.dart';
import '../controller/manage_doctors_state.dart';
import '../widgets/doctor_form_body.dart';
import '../widgets/doctors_app_bar.dart';

class DoctorFormScreen extends StatelessWidget {
  const DoctorFormScreen({super.key, required this.cubit, this.doctor});

  /// The shared feature cubit, handed over by the managing list screen.
  final ManageDoctorsCubit cubit;

  /// When provided the form operates in edit mode and prefills the fields.
  final Doctor? doctor;

  bool get _isEditing => doctor != null;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.offWhiteSoft,
        body: PopScope<Object?>(
          onPopInvokedWithResult: (didPop, result) {
            // The form is a transient consumer of the shared cubit; leave
            // `formStatus` at `initial` so the list screen's error snackbar
            // is not suppressed by a stale status afterwards.
            if (didPop) cubit.resetForm();
          },
          child: BlocListener<ManageDoctorsCubit, ManageDoctorsState>(
            listener: (context, state) {
              if (state.formStatus == DoctorFormStatus.success) {
                onSuccess(context);
              } else if (state.formStatus == DoctorFormStatus.failure) {
                context.showErrorSnackBar(
                  state.errorMessage == null
                      ? (_isEditing
                            ? t.editDoctor.failureMessage
                            : t.createDoctor.failureMessage)
                      : context.resolveAuthCode(state.errorMessage!),
                );
              }
            },
            child: Column(
              children: [
                DoctorsAppBar(
                  title: _isEditing ? t.editDoctor.title : t.createDoctor.title,
                  leading: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 22.r,
                    ),
                  ),
                ),
                Expanded(child: DoctorFormBody(doctor: doctor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSuccess(BuildContext context) {
    final t = context.t;
    context.read<ManageDoctorsCubit>().resetForm();
    context.showSuccessSnackBar(
      _isEditing ? t.editDoctor.successMessage : t.createDoctor.successMessage,
    );
    context.pop();
  }
}
