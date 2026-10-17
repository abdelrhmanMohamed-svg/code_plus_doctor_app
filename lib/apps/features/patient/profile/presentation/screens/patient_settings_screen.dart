import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../common/auth/presentation/controller/auth_cubit.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../../../../common/profile/presentation/controller/user_state.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UserCubit>(),
      child: const _PatientSettingsView(),
    );
  }
}

class _PatientSettingsView extends StatefulWidget {
  const _PatientSettingsView();

  @override
  State<_PatientSettingsView> createState() => _PatientSettingsViewState();
}

class _PatientSettingsViewState extends State<_PatientSettingsView> {
  bool _notificationsEnabled = true;
  String _buildVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _buildVersion = 'v${packageInfo.version}';
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: AppColors.white,
          title: Text(
            context.t.patientSettings.logoutConfirmationTitle,
            style: context.bold20DarkNavy,
          ),
          content: Text(
            context.t.patientSettings.logoutConfirmationMessage,
            style: context.regular16Grey,
          ),
          actions: [
            TextButton(
              onPressed: () => ctx.pop(),
              child: Text(
                context.t.patientSettings.cancel,
                style: context.medium16Green,
              ),
            ),
            TextButton(
              onPressed: () {
                ctx.pop();
                context.read<AuthCubit>().signOut();
              },
              child: Text(
                context.t.patientSettings.ok,
                style: context.medium16Green,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteSoft,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status &&
            curr.status == AuthRequestStatus.error,
        listener: (context, state) {
          context.showErrorSnackBar(context.t.profile.signOutFailure);
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      context.t.patientSettings.settingsTitle,
                      style: context.bold24DarkNavy,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.push(
                          AppRouter.patientEditProfile,
                          extra: context.read<UserCubit>(),
                        ),
                        child: const _ProfileCard(),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        context.t.patientSettings.accountSettings,
                        style: context.medium18DarkNavy,
                      ),
                      SizedBox(height: 16.h),
                      _SettingsItemRow(
                        icon: Icons.lock_outline,
                        label: context.t.patientSettings.changePassword,
                        iconColor: AppColors.red,
                        iconBackgroundColor:
                            AppColors.red.withValues(alpha: 0.1),
                        trailing: Icon(Icons.chevron_right,
                            color: AppColors.greyBlueLight, size: 24.r),
                        onTap: () {},
                      ),
                      SizedBox(height: 16.h),
                      _SettingsItemRow(
                        icon: Icons.notifications_none_outlined,
                        label: context.t.patientSettings.notifications,
                        iconColor: AppColors.green,
                        iconBackgroundColor:
                            AppColors.green.withValues(alpha: 0.1),
                        trailing: CupertinoSwitch(
                          value: _notificationsEnabled,
                          activeTrackColor: AppColors.green,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _SettingsItemRow(
                        icon: Icons.pie_chart_outline, // closest to the pie icon
                        label: context.t.patientSettings.privacyPolicy,
                        iconColor: AppColors.orange,
                        iconBackgroundColor:
                            AppColors.orange.withValues(alpha: 0.1),
                        trailing: Icon(Icons.chevron_right,
                            color: AppColors.greyBlueLight, size: 24.r),
                        onTap: () => context.push(AppRouter.privacyPolicy),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        context.t.patientSettings.moreOptions,
                        style: context.medium18DarkNavy,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.t.patientSettings.languages, style: context.regular16DarkNavy),
                          Row(
                            children: [
                              Text(context.t.patientSettings.english, style: context.regular14Grey),
                              SizedBox(width: 8.w),
                              Icon(Icons.chevron_right, color: AppColors.greyBlueLight, size: 24.r),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.t.patientSettings.buildVersion, style: context.regular16DarkNavy),
                          Text(_buildVersion, style: context.regular14Grey),
                        ],
                      ),
                      SizedBox(height: 48.h),
                      _LogoutButton(onTap: _showLogoutDialog),
                    ],
                  ),
                ),
              ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyBlueLight.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.greenLight,
                backgroundImage: state.profile?.imageUrl != null
                    ? CachedNetworkImageProvider(state.profile!.imageUrl!)
                    : CachedNetworkImageProvider(AppConstants.doctorDefaultPhoto) as ImageProvider,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.profile?.name ?? '',
                      style: context.bold18DarkNavy,
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

class _SettingsItemRow extends StatelessWidget {
  const _SettingsItemRow({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(label, style: context.regular16DarkNavy),
          ),
          trailing,
        ],
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
                context.t.patientSettings.logout,
                style: context.semiBold16Red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
