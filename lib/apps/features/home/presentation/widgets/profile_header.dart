import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../profile/presentation/controller/user_cubit.dart';
import '../../../profile/presentation/controller/user_state.dart';

/// Gradient header with greeting text and profile avatar.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 156.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.green, AppColors.greenLight],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: AppSkeleton(
                  enabled: state.isLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.isLoading
                            ? context.t.home.greeting(name: '')
                            : context.t.home.greeting(name: state.name),
                        style: context.regular20OffWhiteWarm,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        state.isLoading ? 'Skeleton' : context.t.home.userName,
                        style: context.bold25White,
                      ),
                    ],
                  ),
                ),
              ),
              Skeleton.replace(
                width: 60.r,
                height: 60.r,
                child: ClipOval(
                  child: Image.asset(
                    ImageAssets.homeProfile,
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
