import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/extensions/error_mapper.dart';
import '../../../../../core/utils/pref_helper.dart';

import '../../../../../core/widgets/blurred_blob.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/widgets/success_dialog.dart';
import '../../../../../core/widgets/doctor_details_card.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/di/injection.dart';
import '../controller/appointment_booking_cubit.dart';
import '../controller/appointment_booking_state.dart';
import '../widgets/appointment_header.dart';
import '../widgets/date_selector.dart';
import '../widgets/time_slot_grid.dart';
import '../widgets/no_slots_view.dart';

class AppointmentBookingScreen extends StatelessWidget {
  const AppointmentBookingScreen({super.key, required this.doctor});

  final Doctor doctor;

  void _openReviewBottomSheet(
    BuildContext context,
    AppointmentBookingState state,
  ) {
    if (state.selectedDate == null || state.selectedTime == null) {
      context.showErrorSnackBar(context.t.appointmentBooking.selectDateAndTime);
      return;
    }

    final cubit = context.read<AppointmentBookingCubit>();
    final dateFormatted =
        DateFormat('EEEE, MMMM d, yyyy').format(state.selectedDate!);
    final location = state.clinicLocation.isNotEmpty
        ? state.clinicLocation
        : PrefHelper.defaultClinicLocation;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.greyLighter,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Text(
                  context.t.appointmentBooking.reviewTitle,
                  style: context.semiBold18.blackSoft,
                ),
                SizedBox(height: 16.h),
                _buildReviewItem(
                  context,
                  context.t.appointmentBooking.doctorLabel,
                  doctor.name,
                ),
                SizedBox(height: 10.h),
                _buildReviewItem(
                  context,
                  context.t.appointmentBooking.specialtyLabel,
                  doctor.specialty,
                ),
                SizedBox(height: 10.h),
                _buildReviewItem(
                  context,
                  context.t.appointmentBooking.dateTimeLabel,
                  '$dateFormatted at ${state.selectedTime}',
                ),
                SizedBox(height: 10.h),
                _buildReviewItem(
                  context,
                  context.t.appointmentBooking.feeLabel,
                  doctor.price.startsWith('\$')
                      ? doctor.price
                      : '\$${doctor.price}',
                ),
                SizedBox(height: 10.h),
                _buildReviewItem(
                  context,
                  context.t.appointmentBooking.locationLabel,
                  location,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  label: context.t.appointmentBooking.confirmBooking,
                  onTap: () {
                    bottomSheetContext.pop();
                    cubit.confirmBooking();
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewItem(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.regular13.greyPaleBlue,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: context.semiBold13.blackSoft,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppointmentBookingCubit>()..load(doctor),
      child: Scaffold(
        backgroundColor: AppColors.offWhiteSoft,
        body: Stack(
          children: [
            const BackgroundBlobs(),
            SafeArea(
              child: Column(
                children: [
                  const AppointmentHeader(),
                  SizedBox(height: 8.h),
                  DoctorDetailsCard(
                    doctor: doctor,
                    showBookButton: false,
                    showFavoriteIcon: false,
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45.r),
                        ),
                      ),
                      child: BlocConsumer<AppointmentBookingCubit,
                          AppointmentBookingState>(
                        listenWhen: (prev, current) =>
                            prev.isSuccess != current.isSuccess ||
                            prev.errorCode != current.errorCode,
                        listener: (context, state) {
                          if (state.isSuccess) {
                            final dateStr = state.selectedDate != null
                                ? DateFormat('MMMM d, yyyy')
                                    .format(state.selectedDate!)
                                : '';
                            showSuccessDialog(
                              context,
                              title: context.t.thankYou.title,
                              subtitle: context.t.thankYou.subtitle,
                              message: context.t.appointmentBooking
                                  .successMessage(
                                doctor: doctor.name,
                                date: dateStr,
                                time: state.selectedTime ?? '',
                              ),
                              onAction: () {
                                context.pop(); // dismiss dialog
                                context.pop(); // pop screen
                              },
                            );
                          } else if (state.errorCode.isNotEmpty) {
                            context.showErrorSnackBar(
                              context.resolveAuthCode(state.errorCode),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final dateStr = state.selectedDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(state.selectedDate!)
                              : null;
                          final slotsForDate =
                              dateStr != null && state.availableSlotsPerDate.containsKey(dateStr)
                                  ? state.availableSlotsPerDate[dateStr]!
                                  : <String>[];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),
                              DateSelector(
                                dates: state.availableDates,
                                slotsPerDate: state.availableSlotsPerDate,
                                selectedDate: state.selectedDate,
                                onDateSelected: (date) => context
                                    .read<AppointmentBookingCubit>()
                                    .selectDate(date),
                              ),
                              SizedBox(height: 24.h),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: slotsForDate.isEmpty
                                      ? const Center(child: NoSlotsView())
                                      : TimeSlotGrid(
                                          slots: slotsForDate,
                                          selectedTime: state.selectedTime,
                                          onTimeSelected: (time) => context
                                              .read<AppointmentBookingCubit>()
                                              .selectTime(time),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.w),
                                child: PrimaryButton(
                                  label: context.t.appointmentBooking.confirm,
                                  onTap: () =>
                                      _openReviewBottomSheet(context, state),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
