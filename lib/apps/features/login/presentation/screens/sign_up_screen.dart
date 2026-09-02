import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/extensions/snackbar_context.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/utils/app_validator.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == AuthRequestStatus.success) {
                  context.go(AppRouter.home);
                } else if (state.status == AuthRequestStatus.error) {
                  context.showErrorSnackBar(state.errorCode ?? 'generic');
                }
              },
              child: Stack(
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
                          _buildSocialButtons(context),
                          SizedBox(height: 34.h),
                          _buildInputFields(),
                          SizedBox(height: 15.h),
                          _buildTermsRow(),
                          SizedBox(height: 59.h),
                          _buildSignUpButton(context),
                          SizedBox(height: 19.h),
                          _buildLoginPrompt(),
                          SizedBox(height: 28.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
          style: context.bold24Black,
        ),
        SizedBox(height: 14.h),
        Text(
          context.t.signUp.joinSubtitle,
          textAlign: TextAlign.center,
          style: context.regular15.greyPaleBlue.copyWith(height: 1.45),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AuthSocialButton(
            leading: SvgPicture.asset(ImageAssets.googleLogo, height: 20.r),
            label: context.t.signUp.googleLabel,
            onTap: () => context.read<AuthCubit>().signInWithGoogle(),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AuthSocialButton(
            leading: Icon(
              Icons.facebook,
              size: 20.r,
              color: AppColors.blueDark,
            ),
            label: context.t.signUp.facebookLabel,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    final t = context.t;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            hint: t.signUp.nameHint,
            validator: AppValidator.required(t),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: _emailController,
            hint: t.signUp.emailHint,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.email(t),
          ),
          SizedBox(height: 20.h),
          AuthPasswordField(
            controller: _passwordController,
            hint: t.signUp.passwordHint,
            validator: AppValidator.password(t),
          ),
        ],
      ),
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
            style: context.regular13GreyBlueDark,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        return PrimaryButton(
          label: context.t.signUp.button,
          isLoading: state.status == AuthRequestStatus.submitting,
          onTap: () {
            if (!_formKey.currentState!.validate()) return;
            if (!_termsAccepted) {
              context.showErrorSnackBar('auth.termsRequired');
              return;
            }
            context.read<AuthCubit>().signUp(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
            );
          },
        );
      },
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.t.signUp.haveAccount,
          style:context.regular14Green
        ),
        SizedBox(width: 4.w),
        InkWell(
          onTap: () => context.go(AppRouter.login),
          child: Text(
            context.t.signUp.logIn,
            style: context.semiBold14Green
          ),
        ),
      ],
    );
  }
}

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
          color: value ? AppColors.green : AppColors.greyBluePale,
        ),
        child: value
            ? Icon(Icons.check, size: 12.r, color: AppColors.white)
            : null,
      ),
    );
  }
}
