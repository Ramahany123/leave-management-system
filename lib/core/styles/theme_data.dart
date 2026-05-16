import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';

class AppTheme {
  // ==============================
  // 1. LIGHT THEME
  // ==============================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.primaryFont,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
      error: AppColors.errorRed,
    ),
    textTheme: TextTheme(titleLarge: AppTextStyles.headingTextStyle),

    // -- App Bar Styling --
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 24.sp, color: AppColors.blackColor),
      actionsIconTheme: IconThemeData(size: 24.sp, color: AppColors.blackColor),
      titleTextStyle: AppTextStyles.black16w600TextStyle,
    ),

    // -- Primary Button Styling --
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.whiteColor,
        textStyle: AppTextStyles.white16w600TextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        minimumSize: Size(
          double.infinity,
          50.h,
        ), // Standard corporate button height
        elevation: 0,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    // -- Text Field Styling --
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      hintStyle: AppTextStyles.grey18w400TextStyle,
      filled: true,
      fillColor: AppColors.whiteColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: const Color(0xffCBD5E1),
          width: 1.w,
        ), // Light slate border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: AppColors.primaryBlue,
          width: 1.5.w,
        ), // Blue highlight on tap
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.errorRed, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.errorRed, width: 1.5.w),
      ),
    ),
  );

  // ==============================
  // 2. DARK THEME
  // ==============================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.primaryFont,
    scaffoldBackgroundColor: AppColors.blackColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
      error: AppColors.errorRed,
    ),

    // -- App Bar Styling --
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.blackColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 24.sp, color: AppColors.whiteColor),
      actionsIconTheme: IconThemeData(size: 24.sp, color: AppColors.whiteColor),
      titleTextStyle: AppTextStyles.white16w600TextStyle,
    ),

    // -- Primary Button Styling --
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.whiteColor,
        textStyle: AppTextStyles.white16w600TextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        minimumSize: Size(double.infinity, 50.h),
        elevation: 0,
      ),
    ),

    // -- Text Field Styling --
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      hintStyle: AppTextStyles.grey18w400TextStyle,
      filled: true,
      fillColor: const Color(0xff1E293B), // Deep slate for dark mode fields
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: const Color(0xff334155),
          width: 1.w,
        ), // Darker slate border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.errorRed, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.errorRed, width: 1.5.w),
      ),
    ),
  );
}
