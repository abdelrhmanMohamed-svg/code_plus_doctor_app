import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../controller/favourite_doctors_cubit.dart';
import '../controller/favourite_doctors_state.dart';

/// Compact grid card for a favourited doctor (2×2 layout).
class FavouriteDoctorGridCard extends StatelessWidget {
  const FavouriteDoctorGridCard({
    super.key,
    required this.id,
    required this.name,
    required this.specialty,
    required this.photo,
  });

  final String id;
  final String name;
  final String specialty;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: Image.asset(
                  photo,
                  width: 84.r,
                  height: 84.r,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: -4.r,
                child:
                    BlocBuilder<FavouriteDoctorsCubit, FavouriteDoctorsState>(
                      builder: (context, state) => GestureDetector(
                        onTap: () => context
                            .read<FavouriteDoctorsCubit>()
                            .toggleFavorite(id),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: Icon(
                            state.isFavorited(id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 16.r,
                            color: state.isFavorited(id)
                                ? AppColors.redBright
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            style: context.bold15Dark,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            specialty,
            style: context.regular15GreenMint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
