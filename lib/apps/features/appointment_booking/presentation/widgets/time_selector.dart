import 'package:flutter/material.dart';

import '../../../../../i18n/strings.g.dart';
import 'selectable_pill_row.dart';

/// Isolated stateful widget for selecting an appointment time.
///
/// Owns [_selectedTime] and calls its own [setState] on tap,
/// so changing time never rebuilds other selectors.
class TimeSelector extends StatefulWidget {
  const TimeSelector({super.key});

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int _selectedTime = 2; // 02:00 PM selected by default

  List<String> get _times => [
    context.t.appointmentBooking.time10am,
    context.t.appointmentBooking.time12am,
    context.t.appointmentBooking.time2pm,
    context.t.appointmentBooking.time3pm,
    context.t.appointmentBooking.time4pm,
  ];

  @override
  Widget build(BuildContext context) {
    return SelectablePillRow(
      items: _times,
      selectedIndex: _selectedTime,
      onSelect: (index) => setState(() => _selectedTime = index),
    );
  }
}
