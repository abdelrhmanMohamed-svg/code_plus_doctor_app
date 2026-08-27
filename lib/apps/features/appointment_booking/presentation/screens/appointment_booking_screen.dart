import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/success_dialog.dart';
import '../widgets/appointment_header.dart';
import '../widgets/calendar_card.dart';
import '../widgets/reminder_selector.dart';
import '../widgets/time_selector.dart';

/// Appointment booking screen with calendar, time/reminder selectors, and confirm.
///
/// The screen itself is a [StatelessWidget]. Calendar, time, and reminder
/// selectors each own their own state as independent subtrees, so selecting
/// a time never rebuilds the reminder selector and vice versa.
class AppointmentBookingScreen extends StatelessWidget {
  const AppointmentBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appointmentBg,
      body: Stack(
        children: [
          BackgroundBlobs(),
          SafeArea(
            child: Column(
              children: [
                const AppointmentHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const CalendarCard(),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.t.appointmentBooking.availableTime,
                            style: StyleAtom.homeSectionTitle,
                          ),
                          SizedBox(height: 20.h),
                          const TimeSelector(),
                          SizedBox(height: 30.h),
                          Text(
                            context.t.appointmentBooking.reminderMeBefore,
                            style: StyleAtom.homeSectionTitle,
                          ),
                          SizedBox(height: 20.h),
                          const ReminderSelector(),
                          const Spacer(),
                          PrimaryButton(
                            label: context.t.appointmentBooking.confirm,
                            onTap: () {
                              showSuccessDialog(
                                context,
                                title: context.t.thankYou.title,
                                subtitle: context.t.thankYou.subtitle,
                                message: context.t.thankYou.message,
                                actionLabel: context.t.thankYou.editButton,
                                onAction: () {},
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
