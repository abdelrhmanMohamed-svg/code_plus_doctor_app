import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';

class DoctorSpecialtyDropdown extends StatelessWidget {
  const DoctorSpecialtyDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.items,
  });

  final String? selected;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selected,
      onChanged: onChanged,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item, style: context.regular14Black),
            ),
          )
          .toList(),
      style: context.regular16Black,
      decoration: InputDecoration(
        hintText: context.t.createDoctor.specialtyHint,
        hintStyle: context.regular14GreyBlueDark,
        prefixIcon: Icon(
          Icons.medical_services_outlined,
          color: AppColors.greyBlueDark,
          size: 20.r,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        enabledBorder: _border(AppColors.greyBorder),
        focusedBorder: _border(AppColors.green),
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
