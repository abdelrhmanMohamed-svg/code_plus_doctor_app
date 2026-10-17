import 'package:doctor_hunt/apps/core/widgets/doctor_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../controller/doctor_availability_cubit.dart';
import '../controller/doctor_availability_state.dart';
import '../controller/manage_doctors_cubit.dart';
import '../../../shell/presentation/widgets/admin_app_bar.dart';

class AdminDoctorAvailabilityScreen extends StatelessWidget {
  const AdminDoctorAvailabilityScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorAvailabilityCubit>()..init(doctor),
      child: _AdminDoctorAvailabilityView(doctor: doctor),
    );
  }
}

class _AdminDoctorAvailabilityView extends StatelessWidget {
  const _AdminDoctorAvailabilityView({required this.doctor});

  final Doctor doctor;

  static const List<String> _allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _timeOptions = [
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
  ];

  static const List<int> _durationOptions = [15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      appBar: AdminAppBar(
        title: context.t.admin.availabilityTitle,
        showBackButton: true,
      ),
      body: BlocConsumer<DoctorAvailabilityCubit, DoctorAvailabilityState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AvailabilityFormStatus.success) {
            context.showSuccessSnackBar(
              context.t.admin.saveAvailabilitySuccess,
            );
            context.read<ManageDoctorsCubit>().loadDoctors(showLoading: false);
            context.pop();
          } else if (state.status == AvailabilityFormStatus.failure) {
            context.showErrorSnackBar(
              state.errorMessage ?? context.t.admin.saveAvailabilityFailure,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDoctorCard(context),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        context.t.admin.workingDays,
                        style: context.semiBold16Dark,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      context.t.admin.daysEnabled(
                        count: state.workingDays.length,
                      ),
                      style: context.regular13GreyBlueDark,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.greyBorder, width: 0.5),
                  ),
                  child: Column(
                    children: _allDays.map((day) {
                      final isSelected = state.workingDays.contains(day);
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.calendar_month_outlined,
                              color: isSelected
                                  ? AppColors.green
                                  : AppColors.grey,
                              size: 20.r,
                            ),
                            title: Text(
                              day,
                              style: isSelected
                                  ? context.semiBold14Dark
                                  : context.regular14Grey,
                            ),
                            trailing: CupertinoSwitch(
                              value: isSelected,
                              activeTrackColor: AppColors.green,
                              onChanged: (_) {
                                context
                                    .read<DoctorAvailabilityCubit>()
                                    .toggleDay(day);
                              },
                            ),
                          ),
                          if (day != _allDays.last)
                            const Divider(height: 1, color: AppColors.greyBorder),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.t.admin.workingHours,
                  style: context.semiBold16Dark,
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.greyBorder, width: 0.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              context,
                              label: context.t.admin.startTime,
                              value: state.startTime,
                              items: _timeOptions,
                              onChanged: (val) => context
                                  .read<DoctorAvailabilityCubit>()
                                  .updateStartTime(val!),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildDropdown(
                              context,
                              label: context.t.admin.endTime,
                              value: state.endTime,
                              items: _timeOptions,
                              onChanged: (val) => context
                                  .read<DoctorAvailabilityCubit>()
                                  .updateEndTime(val!),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildDropdown(
                        context,
                        label: context.t.admin.slotDuration,
                        value: state.slotDuration,
                        items: _durationOptions,
                        itemBuilder: (val) => '$val Minutes',
                        onChanged: (val) => context
                            .read<DoctorAvailabilityCubit>()
                            .updateSlotDuration(val!),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                PrimaryButton(
                  label: context.t.admin.saveAvailability,
                  isLoading: state.isLoading,
                  onTap: () {
                    context.read<DoctorAvailabilityCubit>().submit(doctor.id);
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greyBorder, width: 0.5),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: DoctorImage(
              photo: doctor.photo,
              width: 56.r,
              height: 56.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: context.semiBold16Dark),
                SizedBox(height: 4.h),
                Text(
                  '${doctor.specialty} · Central Clinic',
                  style: context.regular13GreyBlueDark,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.greenPale,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  context.t.admin.active,
                  style: context.semiBold10GreenDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(
    BuildContext context, {
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String Function(T)? itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.semiBold10Grey.copyWith(letterSpacing: 1.2)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.greyBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.greyBlueDark,
              ),
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16.r,
                          color: AppColors.green,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          itemBuilder != null
                              ? itemBuilder(item)
                              : item.toString(),
                          style: context.semiBold14Dark,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
