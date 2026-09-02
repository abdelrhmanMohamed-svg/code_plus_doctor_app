import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';

/// A selectable role card with distinct selected/unselected visuals.
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: selected ? 164.h : 122.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: selected ? AppColors.greenPale : AppColors.offWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: selected ? AppColors.greenDark : AppColors.greyLight,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.overlayLight,
                  blurRadius: 2.r,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    _buildIconBox(),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: context.semiBold20DarkNavy),
                          if (selected) ...[
                            SizedBox(height: 6.h),
                            Text(
                              body,
                              style: context.regular14GreyMuted,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Positioned(
                  top: 16.r,
                  right: 16.r,
                  child: Icon(
                    Icons.check_circle,
                    size: 24.r,
                    color: AppColors.green,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 56.r,
      height: 56.r,
      decoration: BoxDecoration(
        color: AppColors.greenLighter,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        icon,
        size: 28.r,
        color: selected ? AppColors.green : AppColors.greyMuted,
      ),
    );
  }
}
