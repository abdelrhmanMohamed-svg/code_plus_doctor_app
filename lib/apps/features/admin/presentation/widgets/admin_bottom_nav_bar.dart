import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';

class AdminBottomNavBar extends StatelessWidget {
  const AdminBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 12.r,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: NavigationBar(
          height: 74.h,
          backgroundColor: AppColors.white,
          elevation: 0,
          indicatorColor: AppColors.green,
          indicatorShape: const CircleBorder(),
          selectedIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.person_add_alt,
                size: 22.r,
                color: AppColors.greyBlueLight,
              ),
              selectedIcon: Icon(
                Icons.person_add_alt_1,
                size: 24.r,
                color: AppColors.white,
              ),
              label: context.t.admin.doctorsTitle,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                size: 22.r,
                color: AppColors.greyBlueLight,
              ),
              selectedIcon: Icon(
                Icons.settings,
                size: 24.r,
                color: AppColors.white,
              ),
              label: context.t.admin.settingsTitle,
            ),
          ],
        ),
      ),
    );
  }
}
