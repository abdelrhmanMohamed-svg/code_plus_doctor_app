// GENERATED FROM FIGMA — Doctor Hunt (Code PLus) design system.
// Source of truth: Figma onboarding/choose-role/auth screens. Do not edit by hand.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Typography styles extracted from the Figma design.
class StyleAtom {
  StyleAtom._();

  static const String fontFamilyPlusJakartaSans = 'Plus Jakarta Sans';
  static const String fontFamilyRubik = 'Rubik';

  static TextStyle get onboardingTitle => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
  );

  static TextStyle get onboardingBody =>
      TextStyle(fontSize: 14.sp, height: 1.4, color: AppColors.secondary);

  static TextStyle get onboardingButton => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.background,
  );

  static TextStyle get onboardingSkip =>
      TextStyle(fontSize: 14.sp, color: AppColors.secondary);

  static TextStyle get chooseRoleTitle => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get chooseRoleSubtitle => TextStyle(
    fontSize: 14.sp,
    height: 1.43,
    color: AppColors.roleIconMuted,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get roleCardTitle => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get roleCardBody => TextStyle(
    fontSize: 14.sp,
    color: AppColors.roleIconMuted,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get continueButton => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get brandName => TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brandText,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get authTitle => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get authSubtitle => TextStyle(
    fontSize: 14.sp,
    height: 1.43,
    color: AppColors.secondary,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get fieldLabel => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get fieldInput => TextStyle(
    fontSize: 16.sp,
    color: AppColors.heading,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get fieldHint => TextStyle(
    fontSize: 16.sp,
    color: AppColors.inputHint,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get authLink => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get authSwitchPrompt => TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get homeGreeting => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.homeGreeting,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeUserName => TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.background,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeSearchHint => TextStyle(
    fontSize: 15.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeSectionTitle => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeSeeAll => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w100,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeLiveBadge => TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homePopularName => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeSpecialty => TextStyle(
    fontSize: 12.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeFeatureName => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeFeaturePrice => TextStyle(
    fontSize: 9.sp,
    color: AppColors.featurePrice,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get homeRatingText => TextStyle(
    fontSize: 10.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorsTitle => TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brandText,
    fontFamily: fontFamilyPlusJakartaSans,
  );

  static TextStyle get findDoctorsSearchHint => TextStyle(
    fontSize: 19.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorName => TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorSpecialty => TextStyle(
    fontSize: 17.sp,
    color: AppColors.primary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorExperience => TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorRating => TextStyle(
    fontSize: 13.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorNextAvailable => TextStyle(
    fontSize: 15.sp,
    color: AppColors.primary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorTime => TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get findDoctorBookNow => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.background,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get doctorDetailsTitle => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get doctorDetailsName => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get doctorDetailsSpecialty => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get doctorDetailsPrice => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get statsValue => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get statsLabel => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get servicesTitle => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.title,
    fontFamily: fontFamilyRubik,
  );

  static TextStyle get serviceItem => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.secondary,
    fontFamily: fontFamilyRubik,
  );
}
