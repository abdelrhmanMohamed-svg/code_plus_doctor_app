import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/extensions/snackbar_context.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../login/presentation/controller/auth_cubit.dart';
import '../../../login/presentation/controller/auth_state.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminSettingsView();
  }
}

class _AdminSettingsView extends StatelessWidget {
  const _AdminSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, curr) =>
              prev.status != curr.status &&
              curr.status == AuthRequestStatus.error,
          listener: (context, state) {
            context.showErrorSnackBar(context.t.profile.signOutFailure);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.admin.settingsTitle,
                  style: context.medium24DarkNavy,
                ),
                SizedBox(height: 32.h),
                _SettingsItem(
                  icon: Icons.logout,
                  label: context.t.profile.logout,
                  onTap: () => context.read<AuthCubit>().signOut(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, size: 22.r, color: AppColors.red),
              SizedBox(width: 12.w),
              Text(label, style: context.medium16Dark),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                size: 22.r,
                color: AppColors.greyBlueLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
