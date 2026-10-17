import 'package:doctor_hunt/apps/core/widgets/doctor_image.dart';
import 'package:doctor_hunt/apps/features/admin/manage_doctors/presentation/controller/manage_doctors_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../widgets/doctor_status_badge.dart';
import '../controller/manage_doctors_cubit.dart';
import '../../../shell/presentation/widgets/admin_app_bar.dart';

class AdminDoctorDetailsScreen extends StatelessWidget {
  const AdminDoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      appBar: AdminAppBar(
        title: context.t.admin.doctorDetailsTitle,
        showBackButton: true,
      ),
      body: BlocBuilder<ManageDoctorsCubit, ManageDoctorsState>(
        builder: (context, state) {
          final currentDoctor = state.doctors.firstWhere(
            (d) => d.id == doctor.id,
            orElse: () => doctor,
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: DoctorImage(
                          photo: currentDoctor.photo,
                          width: 100.r,
                          height: 100.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 24.r,
                          height: 24.r,
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(currentDoctor.name, style: context.semiBold24DarkNavy),
                SizedBox(height: 12.h),
                DoctorStatusBadge(isActive: currentDoctor.isActive),
                SizedBox(height: 24.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.greyBorder, width: 0.5),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        context,
                        icon: Icons.medical_services_outlined,
                        title: context.t.admin.specialty,
                        subtitle: currentDoctor.specialty,
                      ),
                      const Divider(height: 1, color: AppColors.greyBorder),
                      _buildDetailRow(
                        context,
                        icon: Icons.star_border,
                        title: context.t.admin.rating,
                        subtitleWidget: Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < currentDoctor.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 14.r,
                                  color: AppColors.yellow,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '${currentDoctor.rating.toStringAsFixed(1)} · ${context.t.admin.reviewsCount(count: currentDoctor.reviewsCount)}',
                              style: context.regular12GreyBlueDark,
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.greyBorder),
                      _buildDetailRow(
                        context,
                        icon: Icons.monetization_on_outlined,
                        title: context.t.admin.consultationFee,
                        subtitle: '\$${currentDoctor.price}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: PrimaryButton(
                    label: context.t.admin.editDoctor,
                    onTap: () {
                      final cubit = context.read<ManageDoctorsCubit>();
                      context.push(
                        AppRouter.editDoctor,
                        extra: (cubit, currentDoctor),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: 295.w,
                    height: 54.h,
                    child: OutlinedButton(
                      onPressed: () {
                        final cubit = context.read<ManageDoctorsCubit>();
                        context.push(
                          AppRouter.adminDoctorAvailability,
                          extra: (cubit, currentDoctor),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.green,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        context.t.admin.manageAvailability,
                        style: context.bold18Green,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? subtitleWidget,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.greenLighter,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColors.green, size: 24.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.regular13GreyBlueDark),
                SizedBox(height: 4.h),
                if (subtitleWidget != null) subtitleWidget,
                if (subtitle != null)
                  Text(subtitle, style: context.semiBold16Dark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
