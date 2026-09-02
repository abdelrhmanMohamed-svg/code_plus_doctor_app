import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// A row of selectable circular pills.
///
/// Stateless — selection state is owned by the parent.
class SelectablePillRow extends StatelessWidget {
  const SelectablePillRow({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(items.length, (index) {
        final bool isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.green
                  : AppColors.green.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              items[index],
              textAlign: TextAlign.center,

              style: isSelected ? context.bold14White : context.semiBold13Green,
            ),
          ),
        );
      }),
    );
  }
}
