import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/extensions/snackbar_context.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../login/presentation/controller/auth_cubit.dart';
import '../../../login/presentation/controller/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status &&
            curr.status == AuthRequestStatus.error,
        listener: (context, state) {
          context.showErrorSnackBar(context.t.profile.signOutFailure);
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Text(context.t.tabs.profile, style: context.semiBold28DarkNavy),
                const Spacer(),
                PrimaryButton(
                  label: context.t.profile.logout,
                  width: double.infinity,
                  height: 56,
                  borderRadius: 16,
                  labelStyle: context.semiBold16White,
                  onTap: () => context.read<AuthCubit>().signOut(),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
