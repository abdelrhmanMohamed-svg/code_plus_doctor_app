import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.dates,
    required this.slotsPerDate,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final List<DateTime> dates;
  final Map<String, List<String>> slotsPerDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final date = dates[index];
          final dateStr = DateFormat('yyyy-MM-dd').format(date);
          final isSelected = selectedDate != null &&
              dateStr == DateFormat('yyyy-MM-dd').format(selectedDate!);

          final slots = slotsPerDate[dateStr] ?? [];
          final slotCount = slots.length;

          // E.g. "Today, 23 Feb" or "Tomorrow, 24 Feb" or "Thu, 25 Feb"
          final now = DateTime.now();
          final todayStr = DateFormat('yyyy-MM-dd').format(now);
          final tomorrowStr = DateFormat('yyyy-MM-dd')
              .format(now.add(const Duration(days: 1)));

          String title;
          if (dateStr == todayStr) {
            title = 'Today, ${DateFormat('d MMM').format(date)}';
          } else if (dateStr == tomorrowStr) {
            title = 'Tomorrow, ${DateFormat('d MMM').format(date)}';
          } else {
            title = DateFormat('EEE, d MMM').format(date);
          }

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.green : AppColors.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.green.withValues(alpha: 0.3),
                          blurRadius: 10.r,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.overlayLight,
                          blurRadius: 20.r,
                          offset: const Offset(0, 0),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: isSelected
                        ? context.medium14White
                        : context.medium14Dark,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    slotCount == 0
                        ? context.t.appointmentBooking.noSlotsAvailable
                        : '$slotCount ${context.t.appointmentBooking.slotsAvailable}',
                    style: isSelected
                        ? context.regular10White
                        : context.regular10Grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
