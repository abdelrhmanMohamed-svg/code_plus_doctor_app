import 'package:flutter/material.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';

/// Placeholder for the appointments tab.
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Center(child: Text(context.t.tabs.appointments))),
    );
  }
}
