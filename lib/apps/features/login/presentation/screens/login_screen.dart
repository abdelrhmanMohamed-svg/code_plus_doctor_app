import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/forgot_password_sheet.dart';

/// Login screen. UI-only; actions are styled placeholders.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 130.h),
                  _buildHeader(),
                  SizedBox(height: 71.h),
                  _buildSocialButtons(),
                  SizedBox(height: 34.h),
                  _buildFields(),
                  SizedBox(height: 59.h),
                  AuthPrimaryButton(
                    label: context.t.login.button,
                    onTap: () => context.go(AppRouter.home),
                  ),
                  SizedBox(height: 21.h),
                  _buildForgotPassword(),
                  SizedBox(height: 37.h),
                  _buildJoinPrompt(),
                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          context.t.login.welcomeBack,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.authTitle,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          context.t.login.joinSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            height: 1.45,
            color: AppColors.authSubtitle,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: AuthSocialButton(
            leading: SvgPicture.asset(ImageAssets.googleLogo, height: 20.r),
            label: context.t.signUp.googleLabel,
            onTap: () {},
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AuthSocialButton(
            leading: Icon(
              Icons.facebook,
              size: 20.r,
              color: AppColors.authFacebookBlue,
            ),
            label: context.t.signUp.facebookLabel,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        SizedBox(
          height: 54.h,
          child: AuthTextField(
            controller: _emailController,
            hint: context.t.signUp.emailHint,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 54.h,
          child: AuthPasswordField(
            controller: _passwordController,
            hint: context.t.signUp.passwordHint,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Center(
      child: InkWell(
        onTap: () => showForgotPasswordSheet(context),
        borderRadius: BorderRadius.circular(6.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            context.t.login.forgotPassword,
            style: StyleAtom.authLink,
          ),
        ),
      ),
    );
  }

  Widget _buildJoinPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.t.login.dontHaveAccount,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.primary,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
        SizedBox(width: 4.w),
        InkWell(
          onTap: () => context.go(AppRouter.signUp),
          borderRadius: BorderRadius.circular(6.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Text(
              context.t.login.joinUs,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
