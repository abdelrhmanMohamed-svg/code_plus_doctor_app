import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/specialty_options.dart';

/// Specialty filter picker shown as a bottom sheet.
///
/// Returns the selected specialty, or an empty string for "All".
Future<String> showSpecialtyFilterSheet(
  BuildContext context, {
  required String current,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetContext) {
      return _SpecialtyFilterSheet(current: current);
    },
  ).then((selected) => selected ?? '');
}

class _SpecialtyFilterSheet extends StatelessWidget {
  const _SpecialtyFilterSheet({required this.current});

  final String current;

  @override
  Widget build(BuildContext context) {
    final options = specialtyOptions(context.t);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              context.t.admin.filterTitle,
              style: context.semiBold16Dark,
            ),
          ),
          _FilterOption(
            label: context.t.admin.filterAll,
            isSelected: current.isEmpty,
            onTap: () => Navigator.pop(context, ''),
          ),
          for (final specialty in options)
            _FilterOption(
              label: specialty,
              isSelected: current == specialty,
              onTap: () => Navigator.pop(context, specialty),
            ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: isSelected
                    ? context.semiBold14Dark
                    : context.regular14Black,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.green, size: 20.r),
          ],
        ),
      ),
    );
  }
}
