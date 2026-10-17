import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/image_assets.dart';
import '../../../../common/auth/presentation/controller/auth_cubit.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../../../../common/profile/presentation/controller/user_state.dart';
import '../../../shell/presentation/widgets/admin_app_bar.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UserCubit>(),
      child: const _AdminSettingsView(),
    );
  }
}

class _AdminSettingsView extends StatelessWidget {
  const _AdminSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      appBar: AdminAppBar(
        title: context.t.admin.settingsTitle,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status &&
            curr.status == AuthRequestStatus.error,
        listener: (context, state) {
          context.showErrorSnackBar(context.t.profile.signOutFailure);
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              const _ProfileCard(),
              SizedBox(height: 24.h),
              _SettingsItem(
                icon: Icons.person_outline,
                label: context.t.adminSettings.adminProfile,
                subtitle: context.t.adminSettings.adminProfileDesc,
                onTap: () => context.push(
                  AppRouter.adminEditProfile,
                  extra: context.read<UserCubit>(),
                ),
              ),
              SizedBox(height: 16.h),
              _SettingsItem(
                icon: Icons.lock_outline,
                label: context.t.adminSettings.changePassword,
                subtitle: context.t.adminSettings.changePasswordDesc,
                onTap: () {}, // Non-functional for now
              ),
              SizedBox(height: 16.h),
              _SettingsItem(
                icon: Icons.info_outline,
                label: context.t.adminSettings.appInfo,
                subtitle: context.t.adminSettings.appInfoDesc,
                trailingText: '1.0.0', // TODO: use package_info_plus
                onTap: () {}, // Non-functional for now
              ),
              SizedBox(height: 48.h),
              _LogoutButton(onTap: () => context.read<AuthCubit>().signOut()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.greenLight,
                backgroundImage: state.profile?.imageUrl != null
                    ? NetworkImage(state.profile!.imageUrl!)
                    : const AssetImage(ImageAssets.homeProfile)
                          as ImageProvider,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.profile?.name ?? '',
                      style: context.semiBold18Dark,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      state.profile?.email ?? '',
                      style: context.regular14Grey,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.trailingText,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final String? trailingText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.green, size: 24.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: context.semiBold16Dark),
                    SizedBox(height: 4.h),
                    Text(subtitle, style: context.regular12Grey),
                  ],
                ),
              ),
              if (trailingText != null)
                Text(trailingText!, style: context.regular14Grey)
              else
                Icon(
                  Icons.chevron_right,
                  color: AppColors.greyBlueLight,
                  size: 24.r,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.red.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: AppColors.red, size: 20.r),
              SizedBox(width: 8.w),
              Text(
                context.t.adminSettings.logout,
                style: context.semiBold16Red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
