import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../login/presentation/widgets/auth_text_field.dart';

class DoctorSearchBar extends StatelessWidget {
  const DoctorSearchBar({super.key, required this.onChanged, this.onFilterTap});

  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greyBorder, width: 1),
              ),
              child: CustomTextField(
                onChanged: onChanged,
                style: context.regular14Black,
                hint: context.t.admin.searchHint,
                hintStyle: context.regular14GreyBlueDark,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.greyBlueDark,
                  size: 20.r,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greyBorder, width: 1),
              ),
              child: Icon(
                Icons.filter_list,
                color: AppColors.greyBlueDark,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
