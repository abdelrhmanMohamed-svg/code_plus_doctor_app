import 'package:flutter/material.dart';

import '../../../../../i18n/strings.g.dart';
import 'selectable_pill_row.dart';

/// Isolated stateful widget for selecting a reminder interval.
///
/// Owns [_selectedReminder] and calls its own [setState] on tap,
/// so changing reminder never rebuilds other selectors.
class ReminderSelector extends StatefulWidget {
  const ReminderSelector({super.key});

  @override
  State<ReminderSelector> createState() => _ReminderSelectorState();
}

class _ReminderSelectorState extends State<ReminderSelector> {
  int _selectedReminder = 2; // 25 selected by default

  List<String> get _reminders => [
    context.t.appointmentBooking.reminder30,
    context.t.appointmentBooking.reminder40,
    context.t.appointmentBooking.reminder25,
    context.t.appointmentBooking.reminder10,
    context.t.appointmentBooking.reminder35,
  ];

  @override
  Widget build(BuildContext context) {
    return SelectablePillRow(
      items: _reminders,
      selectedIndex: _selectedReminder,
      onSelect: (index) => setState(() => _selectedReminder = index),
    );
  }
}
