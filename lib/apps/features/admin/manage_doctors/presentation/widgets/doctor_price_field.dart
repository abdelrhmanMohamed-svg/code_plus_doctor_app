import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';

class DoctorPriceField extends StatelessWidget {
  const DoctorPriceField({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required'; // Or use translator
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.semiBold16Black,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.regular14GreyBlueDark,
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
