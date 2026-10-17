import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/specialty_options.dart';

class FindDoctorsFilterChips extends StatelessWidget {
  const FindDoctorsFilterChips({
    super.key,
    required this.selectedSpecialty,
    required this.onSelected,
  });

  final String selectedSpecialty;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = specialtyOptions(context.t);
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: options.length + 1,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final specialty = isAll ? '' : options[index - 1];
          final label = isAll ? context.t.admin.filterAll : specialty;
          final isSelected = selectedSpecialty == specialty;

          return GestureDetector(
            onTap: () => onSelected(specialty),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.green : AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.green : AppColors.greyBorder,
                  width: 1,
                ),
              ),
              child: Text(
                label,
                style: isSelected
                    ? context.medium14White
                    : context.regular14GreyBlueDark,
              ),
            ),
          );
        },
      ),
    );
  }
}

