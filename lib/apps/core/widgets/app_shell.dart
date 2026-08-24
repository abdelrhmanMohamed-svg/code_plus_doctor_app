import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../i18n/strings.g.dart';
import '../theme/app_colors.dart';

/// Scaffold hosting the persistent bottom navigation for the main tabs.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: _AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _AppBottomNavBar extends StatelessWidget {
  const _AppBottomNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12.r,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: NavigationBar(
          height: 74.h,
          backgroundColor: AppColors.background,
          elevation: 0,
          indicatorColor: AppColors.primary,
          indicatorShape: const CircleBorder(),
          selectedIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 22.r,
                color: AppColors.navIconInactive,
              ),
              selectedIcon: Icon(
                Icons.home,
                size: 24.r,
                color: AppColors.background,
              ),
              label: context.t.tabs.home,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 22.r,
                color: AppColors.navIconInactive,
              ),
              selectedIcon: Icon(
                Icons.calendar_month,
                size: 24.r,
                color: AppColors.background,
              ),
              label: context.t.tabs.appointments,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 22.r,
                color: AppColors.navIconInactive,
              ),
              selectedIcon: Icon(
                Icons.chat_bubble,
                size: 24.r,
                color: AppColors.background,
              ),
              label: context.t.tabs.chat,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                size: 22.r,
                color: AppColors.navIconInactive,
              ),
              selectedIcon: Icon(
                Icons.person,
                size: 24.r,
                color: AppColors.background,
              ),
              label: context.t.tabs.profile,
            ),
          ],
        ),
      ),
    );
  }
}
