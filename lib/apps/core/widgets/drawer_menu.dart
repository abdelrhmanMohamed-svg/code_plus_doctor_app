import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../i18n/strings.g.dart';
import '../../../../generated/style_atoms.dart';
import '../../features/common/auth/presentation/controller/auth_cubit.dart';
import '../../features/common/profile/presentation/controller/user_cubit.dart';
import '../../features/common/profile/presentation/controller/user_state.dart';
import '../di/injection.dart';
import '../theme/app_colors.dart';
import '../utils/app_constants.dart';

/// The side menu displayed in the advanced drawer.
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.navigationShell,
    required this.onClose,
  });

  final StatefulNavigationShell navigationShell;
  final VoidCallback onClose;

  void _onNavigate(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    onClose();
  }

  void _onLogout(BuildContext context) {
    getIt<AuthCubit>().signOut();
    onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileInfo(context),
              SizedBox(height: 50.h),
              _MenuTile(
                icon: Icons.person_outline,
                label: context.t.tabs.home,
                onTap: () => _onNavigate(0),
              ),
              _MenuTile(
                icon: Icons.favorite_outline,
                label: context.t.tabs.favourites,
                onTap: () => _onNavigate(1),
              ),
              _MenuTile(
                icon: Icons.menu_book_outlined,
                label: context.t.tabs.appointments,
                onTap: () => _onNavigate(2),
              ),
              _MenuTile(
                icon: Icons.settings_outlined,
                label: context.t.patientSettings.settingsTitle,
                onTap: () => _onNavigate(3),
              ),
              const Spacer(),
              _MenuTile(
                icon: Icons.logout,
                label: context.t.profile.logout,
                onTap: () => _onLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UserCubit>(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      state.profile?.imageUrl ??
                      AppConstants.doctorDefaultPhoto,
                  width: 50.r,
                  height: 50.r,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    size: 50.r,
                    color: AppColors.greyBlueLight,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.profile?.name ?? 'Loading...',
                      style: context.medium16White,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    if (state.profile?.phone != null)
                      Row(
                        children: [
                          Icon(Icons.phone, size: 12.r, color: AppColors.white),
                          SizedBox(width: 4.w),
                          Text(
                            state.profile!.phone!,
                            style: context.regular12White,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.white, size: 24.r),
      title: Text(label, style: context.medium16White),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.white,
        size: 14.r,
      ),
      onTap: onTap,
    );
  }
}
