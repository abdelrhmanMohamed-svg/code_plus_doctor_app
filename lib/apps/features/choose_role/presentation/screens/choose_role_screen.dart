import 'package:doctor_hunt/apps/features/profile/data/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../controller/choose_role_cubit.dart';
import '../controller/choose_role_state.dart';
import '../widgets/role_card.dart';

/// Role selection screen with two selectable role cards.
class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseRoleCubit>(
      create: (_) => getIt<ChooseRoleCubit>(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              const BackgroundBlobs(),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildBranding(context),
                      _buildHeader(context),
                      SizedBox(height: 32.h),
                      _buildRoleCards(context),
                      const Spacer(),
                      _buildContinueButton(context),
                      SizedBox(height: 32.h),
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

  Widget _buildBranding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Image.asset(ImageAssets.logo, width: 70.r, height: 70.r),
          SizedBox(height: 11.h),
          Text(context.t.common.brandName, style: context.bold25BlackSoft),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7.h),
        Text(
          context.t.chooseRole.title,
          textAlign: TextAlign.center,
          style: context.regular28DarkNavy,
        ),
        SizedBox(height: 8.h),
        Text(
          context.t.chooseRole.subtitle,
          textAlign: TextAlign.center,
          style: context.regular14GreyMuted,
        ),
      ],
    );
  }

  Widget _buildRoleCards(BuildContext context) {
    return BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
      builder: (context, state) => Column(
        children: [
          RoleCard(
            icon: Icons.person_outline,
            title: context.t.chooseRole.patient,
            body: context.t.chooseRole.patientDescription,
            selected: state.selectedRole == Role.patient,
            onTap: () =>
                context.read<ChooseRoleCubit>().selectRole(Role.patient),
          ),
          SizedBox(height: 16.h),
          RoleCard(
            icon: Icons.admin_panel_settings_outlined,
            title: context.t.chooseRole.admin,
            body: context.t.chooseRole.adminDescription,
            selected: state.selectedRole == Role.admin,
            onTap: () => context.read<ChooseRoleCubit>().selectRole(Role.admin),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return PrimaryButton(
      label: context.t.chooseRole.continueButton,
      onTap: () {
        final selectedRole = context.read<ChooseRoleCubit>().state.selectedRole;
        context.go(AppRouter.login, extra: selectedRole);
      },
      width: double.infinity,
      height: 56,
      boxShadow: [
        BoxShadow(
          color: AppColors.overlayLight,
          blurRadius: 2.r,
          offset: const Offset(0, 1),
        ),
      ],
      labelStyle: context.semiBold16White,
    );
  }
}
