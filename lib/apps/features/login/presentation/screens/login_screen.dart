import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extensions/snackbar_context.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/forgot_password_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
                } else if (state.status == AuthRequestStatus.error &&
                    state.errorCode != 'google-signin-canceled') {
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
                        children: [
                          SizedBox(height: 130.h),
                          _buildHeader(),
                          SizedBox(height: 71.h),
                          _buildSocialButtons(context),
                          SizedBox(height: 34.h),
                          _buildFields(),
                          SizedBox(height: 59.h),
                          _buildLoginButton(context),
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
          context.t.login.welcomeBack,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: context.bold24Black,
        ),
        SizedBox(height: 14.h),
        Text(
          context.t.login.joinSubtitle,
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

  Widget _buildFields() {
    final t = context.t;
    return Form(
      key: _formKey,
      child: Column(
        children: [
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

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        return PrimaryButton(
          label: context.t.login.button,
          isLoading: state.status == AuthRequestStatus.submitting,
          onTap: () {
            if (!_formKey.currentState!.validate()) return;
            final email = _emailController.text.trim();
            final password = _passwordController.text;
            context.read<AuthCubit>().signIn(email: email, password: password);
          },
        );
      },
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
            style: context.semiBold14Green,
          ),
        ),
      ),
    );
  }

  Widget _buildJoinPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.t.login.dontHaveAccount, style: context.regular14Green),
        SizedBox(width: 4.w),
        InkWell(
          onTap: () => context.go(AppRouter.signUp),
          borderRadius: BorderRadius.circular(6.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Text(context.t.login.joinUs, style: context.semiBold14Green),
          ),
        ),
      ],
    );
  }
}
