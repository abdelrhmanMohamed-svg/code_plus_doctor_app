import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_password_field.dart';
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
  final _emailFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _step == _ForgotStep.reset ? 470 : 360.h,
      decoration: BoxDecoration(
        color: AppColors.white,
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
    final t = context.t;
    return Form(
      key: _emailFormKey,
      child: Column(
        key: const ValueKey('emailStep'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            t.forgotPassword.sheetTitle,
            t.forgotPassword.sheetBody,
          ),
          SizedBox(height: 28.h),
          CustomTextField(
            controller: _emailController,
            hint: t.signUp.emailHint,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.email(t),
          ),
          SizedBox(height: 32.h),
          PrimaryButton(
            label: t.chooseRole.continueButton,
            onTap: () {
              if (!_emailFormKey.currentState!.validate()) return;
              _advance();
            },
          ),
        ],
      ),
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
    final t = context.t;
    return Form(
      key: _resetFormKey,
      child: Column(
        key: const ValueKey('resetStep'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            t.forgotPassword.resetPasswordSheetTitle,
            t.forgotPassword.resetPasswordSheetBody,
          ),
          SizedBox(height: 28.h),
          AuthPasswordField(
            controller: _newPasswordController,
            hint: t.forgotPassword.newPasswordHint,
            validator: AppValidator.password(t),
          ),
          SizedBox(height: 20.h),
          AuthPasswordField(
            controller: _reEnterPasswordController,
            hint: t.forgotPassword.reEnterPasswordHint,
            validator: AppValidator.confirmPassword(t, _newPasswordController),
          ),
          SizedBox(height: 32.h),
          PrimaryButton(
            label: t.forgotPassword.updatePasswordButton,
            onTap: () {
              if (!_resetFormKey.currentState!.validate()) return;
              context.pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeader(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.bold24.black),
        SizedBox(height: 10.h),
        Text(
          body,
          style: context.regular15.greyPaleBlue.copyWith(height: 1.45),
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
          fillColor: AppColors.white,
          focusedFillColor: AppColors.white,
          filledFillColor: AppColors.white,
          borderColor: AppColors.greyBorderSoft,
          focusedBorderColor: AppColors.green,
          filledBorderColor: AppColors.greyBorderSoft,
          textStyle: context.semiBold20.black,
        ),
      ),
    );
  }
}
