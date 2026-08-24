import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/theme/style_atom.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<ChooseRoleCubit>(
              create: (_) => getIt<ChooseRoleCubit>(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildBranding(context),
                    _buildHeader(context),
                    SizedBox(height: 32.h),
                    _buildRoleCards(),
                    const Spacer(),
                    _buildContinueButton(context),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          Text(context.t.common.brandName, style: StyleAtom.brandName),
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
          style: StyleAtom.chooseRoleTitle,
        ),
        SizedBox(height: 8.h),
        Text(
          context.t.chooseRole.subtitle,
          textAlign: TextAlign.center,
          style: StyleAtom.chooseRoleSubtitle,
        ),
      ],
    );
  }

  Widget _buildRoleCards() {
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
            icon: Icons.medical_services_outlined,
            title: context.t.chooseRole.doctor,
            body: context.t.chooseRole.doctorDescription,
            selected: state.selectedRole == Role.admin,
            onTap: () => context.read<ChooseRoleCubit>().selectRole(Role.admin),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 2.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () => context.go(AppRouter.login),
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Text(
              context.t.chooseRole.continueButton,
              style: StyleAtom.continueButton,
            ),
          ),
        ),
      ),
    );
  }
}
