import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.chevron_left, color: AppColors.darkNavy, size: 24.r),
          ),
        ),
        title: Text(
          context.t.patientSettings.privacyPolicyTitle,
          style: context.bold20DarkNavy,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor Hunt Apps Privacy Policy',
              style: context.bold18DarkNavy,
            ),
            SizedBox(height: 16.h),
            Text(
              context.t.patientSettings.privacyPolicyContent,
              style: context.regular14Grey.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
