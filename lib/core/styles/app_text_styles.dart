import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Make sure this path matches your project structure:
import 'package:leave_management_system/core/styles/app_colors.dart';

class AppTextStyles {
  // Great for screen titles like "Manager Overview"
  static final headingTextStyle = TextStyle(
    fontSize: 32.sp,
    color: AppColors
        .primaryBlue, // Using brand blue for main headings looks very premium
    fontWeight: FontWeight.w700,
  );

  static final black24w600TextStyle = TextStyle(
    fontSize: 24.sp,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w600,
  );

  static final black16w600TextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w600,
  );

  static final black16w500TextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w500,
  );

  static final black14w500TextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w500,
  );

  static final grey18w400TextStyle = TextStyle(
    fontSize: 18.sp,
    color: AppColors.greyColor,
    fontWeight: FontWeight.w400,
  );

  static final grey16w400TextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.greyColor,
    fontWeight: FontWeight.w400,
  );

  static final grey14w400TextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.greyColor,
    fontWeight: FontWeight.w400,
  );

  static final grey12w500TextStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.greyColor,
    fontWeight: FontWeight.w500,
  );

  static final white14w500TextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
  );

  // Perfect for the text inside your primary action buttons (like "Submit Request")
  static final white16w600TextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
  );

  static final primaryBlue20w600TextStyle = TextStyle(
    fontSize: 20.sp,
    color: AppColors.primaryBlue,
    fontWeight: FontWeight.w600,
  );

  // Added this for text buttons or links (like "Forgot Password?")
  static final primary14w600TextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.primaryBlue,
    fontWeight: FontWeight.w600,
  );

  static final primary16w600TextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.primaryBlue,
    fontWeight: FontWeight.w600,
  );
}
