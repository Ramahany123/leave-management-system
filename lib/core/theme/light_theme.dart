import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_typography.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.slate50,
      primaryColor: AppColors.navy900,
      colorScheme: const ColorScheme.light(
        primary: AppColors.navy900,
        secondary: AppColors.navy700,
        surface: AppColors.white,
        onSurface: AppColors.slate900,
        onSurfaceVariant: AppColors.slate500,
        outline: AppColors.slate200,
        error: AppColors.errorRed,
      ),
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.slate900,
        displayColor: AppColors.navy900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.slate500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.navy900, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.slate200.withValues(alpha: 0.3)),
        ),
      ),
    );
