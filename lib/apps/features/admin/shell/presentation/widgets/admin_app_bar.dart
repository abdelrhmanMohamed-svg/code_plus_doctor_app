import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/back_button.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../../../../common/profile/presentation/controller/user_state.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhiteSoft, // Matches the scaffold background usually
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 16.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Row(
        children: [
          if (showBackButton) ...[
            CustomBackButton(onPressed: () => context.pop()),
            SizedBox(width: 16.w),
          ],
          Expanded(
            child: Text(
              title,
              style: context.bold24DarkNavy, // Adjust style if needed
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.darkNavy,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 16.w),
          BlocProvider.value(
            value: getIt<UserCubit>(),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.green,
                  backgroundImage: state.profile?.imageUrl != null
                      ? NetworkImage(state.profile!.imageUrl!)
                      : null,
                  child: state.profile?.imageUrl == null
                      ? Text(
                          state.profile?.name.isNotEmpty == true
                              ? state.profile!.name[0].toUpperCase()
                              : 'A',
                          style: context.semiBold16White,
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h); // Approximate height, doesn't matter much for custom containers unless used in Scaffold.appBar
}
