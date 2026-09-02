import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/utils/image_assets.dart';

/// Horizontal scroll of live-streaming doctor cards.
class LiveDoctorsSection extends StatelessWidget {
  const LiveDoctorsSection({super.key});

  static const List<String> _livePhotos = [
    ImageAssets.liveDoctor1,
    ImageAssets.liveDoctor2,
    ImageAssets.liveDoctor3,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            context.t.home.liveDoctors,
            style: context.medium18Dark,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 168.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: _livePhotos.length,
            separatorBuilder: (context, index) => SizedBox(width: 15.w),
            itemBuilder: (context, index) =>
                _LiveDoctorCard(photo: _livePhotos[index]),
          ),
        ),
      ],
    );
  }
}

class _LiveDoctorCard extends StatelessWidget {
  const _LiveDoctorCard({required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116.w,
      height: 168.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(photo, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(color: AppColors.overlay),
            ),
            Positioned(top: 11.h, right: 11.w, child: const _LiveBadge()),
            const Center(child: _PlayOverlay()),
          ],
        ),
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.r,
            height: 5.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 4.w),
          Text(context.t.home.liveBadge, style: context.semiBold9White),
        ],
      ),
    );
  }
}

class _PlayOverlay extends StatelessWidget {
  const _PlayOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.r,
      height: 35.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: AppColors.white, width: 4),
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        size: 18.r,
        color: AppColors.white,
      ),
    );
  }
}
