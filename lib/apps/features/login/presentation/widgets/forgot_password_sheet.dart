import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../widgets/auth_password_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_text_field.dart';

/// Opens the forgot-password sheet (email → code → reset) from the login screen.
void showForgotPasswordSheet(BuildContext context) {
  showModalBottomSheet<void>(
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ForgotPasswordSheet(),
  );
}

enum _ForgotStep { email, code, reset }

/// Bottom sheet housing the reset flow; pure local presentation state.
class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  _ForgotStep _step = _ForgotStep.email;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  void _advance() {
    setState(() {
      _step = _step == _ForgotStep.email ? _ForgotStep.code : _ForgotStep.reset;
    });
  }

  void _close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _step == _ForgotStep.reset ? 470 : 360.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            left: 20.w,
            right: 20.w,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 24.h,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: switch (_step) {
              _ForgotStep.email => _buildEmailStep(),
              _ForgotStep.code => _buildCodeStep(),
              _ForgotStep.reset => _buildResetStep(),
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmailStep() {
    return Column(
      key: const ValueKey('emailStep'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          context.t.forgotPassword.sheetTitle,
          context.t.forgotPassword.sheetBody,
        ),
        SizedBox(height: 28.h),
        SizedBox(
          height: 54.h,
          child: AuthTextField(
            controller: _emailController,
            hint: context.t.signUp.emailHint,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 32.h),
        PrimaryButton(
          label: context.t.chooseRole.continueButton,
          onTap: _advance,
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      key: const ValueKey('codeStep'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          context.t.forgotPassword.enterCodeSheetTitle,
          context.t.forgotPassword.enterCodeSheetBody,
        ),
        SizedBox(height: 28.h),
        _buildCodeField(),
        SizedBox(height: 32.h),
        PrimaryButton(
          label: context.t.chooseRole.continueButton,
          onTap: _advance,
        ),
      ],
    );
  }

  Widget _buildResetStep() {
    return Column(
      key: const ValueKey('resetStep'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          context.t.forgotPassword.resetPasswordSheetTitle,
          context.t.forgotPassword.resetPasswordSheetBody,
        ),
        SizedBox(height: 28.h),
        SizedBox(
          height: 54.h,
          child: AuthPasswordField(
            controller: _newPasswordController,
            hint: context.t.forgotPassword.newPasswordHint,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 54.h,
          child: AuthPasswordField(
            controller: _reEnterPasswordController,
            hint: context.t.forgotPassword.reEnterPasswordHint,
          ),
        ),
        SizedBox(height: 32.h),
        PrimaryButton(
          label: context.t.forgotPassword.updatePasswordButton,
          onTap: _close,
        ),
      ],
    );
  }

  Widget _buildStepHeader(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.authTitle,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          body,
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

  Widget _buildCodeField() {
    return Align(
      alignment: Alignment.center,
      child: MaterialPinField(
        length: 4,
        autoFocus: true,
        theme: MaterialPinTheme(
          shape: MaterialPinShape.outlined,
          cellSize: Size(60.w, 54.h),
          spacing: 12.w,
          borderRadius: BorderRadius.circular(12.r),
          borderWidth: 1,
          focusedBorderWidth: 1,
          fillColor: Colors.white,
          focusedFillColor: Colors.white,
          filledFillColor: Colors.white,
          borderColor: AppColors.authInputBorder,
          focusedBorderColor: AppColors.primary,
          filledBorderColor: AppColors.authInputBorder,
          textStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTitle,
            fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
          ),
        ),
      ),
    );
  }
}
