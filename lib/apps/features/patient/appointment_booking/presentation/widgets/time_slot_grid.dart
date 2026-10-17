import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';

class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  final List<String> slots;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    // Group slots into Morning, Afternoon, Evening
    final morningSlots = <String>[];
    final afternoonSlots = <String>[];
    final eveningSlots = <String>[];

    final format = DateFormat('hh:mm a');

    for (final slot in slots) {
      try {
        final time = format.parse(slot);
        if (time.hour < 12) {
          morningSlots.add(slot);
        } else if (time.hour < 17) {
          afternoonSlots.add(slot);
        } else {
          eveningSlots.add(slot);
        }
      } catch (_) {}
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (morningSlots.isNotEmpty)
            _buildSection(context, context.t.appointmentBooking.morning, morningSlots),
          if (afternoonSlots.isNotEmpty)
            _buildSection(context, context.t.appointmentBooking.afternoon, afternoonSlots),
          if (eveningSlots.isNotEmpty)
            _buildSection(context, context.t.appointmentBooking.evening, eveningSlots),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> sectionSlots) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ${sectionSlots.length} ${context.t.appointmentBooking.slots}',
            style: context.medium16Dark,
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: sectionSlots.map((slot) {
              final isSelected = selectedTime == slot;
              return GestureDetector(
                onTap: () => onTimeSelected(slot),
                child: Container(
                  width: 76.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.green : AppColors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.green
                          : AppColors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    slot,
                    style: isSelected ? context.medium14White : context.medium14Green,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
