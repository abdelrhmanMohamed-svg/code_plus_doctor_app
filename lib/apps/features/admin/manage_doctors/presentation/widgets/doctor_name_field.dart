import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_validator.dart';

class DoctorNameField extends StatelessWidget {
  const DoctorNameField({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return TextFormField(
      controller: controller,
      validator: AppValidator.required(t),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.regular16Black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.regular14GreyBlueDark,
        prefixIcon: Icon(
          Icons.person_outline,
          color: AppColors.greyBlueDark,
          size: 20.r,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        enabledBorder: _border(AppColors.greyBorder),
        focusedBorder: _border(AppColors.green),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder: _border(AppColors.red),
      ),
    );
  }
}

InputBorder _border(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(color: color, width: 1),
  );
}
