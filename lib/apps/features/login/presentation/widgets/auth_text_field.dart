import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// White rounded input matching the auth reference.
///
/// Pass [onChanged] (without [controller]) for search-bar usage,
/// or [controller] + [hint] for auth form usage.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.prefixIcon,
    this.cursorColor,
    this.textAlignVertical,
    this.style,
    this.hintStyle,
    this.border,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Color? cursorColor;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;

  InputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: cursorColor,
      textAlignVertical: textAlignVertical,
      style: style ?? context.regular16Black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle ?? context.regular16GreyBlueDark,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 21.w, vertical: 16.h),
        border: border ?? _border(AppColors.greyBorderSoft),
        enabledBorder: border ?? _border(AppColors.greyBorderSoft),
        focusedBorder: _border(AppColors.green),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder: _border(AppColors.red),
      ),
    );
  }
}
