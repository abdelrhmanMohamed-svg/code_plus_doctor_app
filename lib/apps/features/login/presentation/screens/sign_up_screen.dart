import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/auth_text_field.dart';

/// Sign Up screen. UI-only; actions are styled placeholders.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 130.h),
                  _buildHeader(),
                  SizedBox(height: 71.h),
                  _buildSocialButtons(),
                  SizedBox(height: 34.h),
                  _buildInputFields(),
                  SizedBox(height: 15.h),
                  _buildTermsRow(),
                  SizedBox(height: 59.h),
                  AuthPrimaryButton(
                    label: context.t.signUp.button,
                    onTap: () {},
                  ),
                  SizedBox(height: 19.h),
                  _buildLoginPrompt(),
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
          context.t.signUp.joinTitle,
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
          context.t.signUp.joinSubtitle,
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

  Widget _buildInputFields() {
    return Column(
      children: [
        SizedBox(
          height: 54.h,
          child: AuthTextField(
            controller: _nameController,
            hint: context.t.signUp.nameHint,
          ),
        ),
        SizedBox(height: 20.h),
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

  Widget _buildTermsRow() {
    return Row(
      children: [
        _TermsCheckbox(
          value: _termsAccepted,
          onChanged: (value) => setState(() => _termsAccepted = value),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            context.t.signUp.termsAgreement,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.authMutedText,
              fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.t.signUp.haveAccount,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.primary,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
        SizedBox(width: 4.w),
        InkWell(
          onTap: () => context.go(AppRouter.login),
          child: Text(
            context.t.signUp.logIn,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
            ),
          ),
        ),
      ],
    );
  }
}

/// Small circular terms-agreement check control per the reference.
class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 18.r,
        height: 18.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? AppColors.primary : AppColors.authCheckbox,
        ),
        child: value
            ? Icon(Icons.check, size: 12.r, color: AppColors.background)
            : null,
      ),
    );
  }
}
