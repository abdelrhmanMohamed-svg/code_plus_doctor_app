import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/theme/app_colors.dart';

/// White rounded card wrapping [SfDateRangePicker] with a green header bar.
///
/// Owns its own selection state as an independent subtree.
class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 280.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,

          initialDisplayDate: DateTime(2021, 2, 1),
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: AppColors.primary,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: 'EEE',
          ),
          selectionTextStyle: const TextStyle(color: Colors.white),
          selectionColor: AppColors.primary,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            setState(() {});
          },
        ),
      ),
    );
  }
}
