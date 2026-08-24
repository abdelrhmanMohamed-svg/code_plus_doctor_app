import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

/// White rounded input matching the auth reference.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  InputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.authTitle,
        fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.authMutedText,
          fontFamily: StyleAtom.fontFamilyPlusJakartaSans,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 16.h),
        enabledBorder: _border(AppColors.authInputBorder),
        focusedBorder: _border(AppColors.primary),
      ),
    );
  }
}
