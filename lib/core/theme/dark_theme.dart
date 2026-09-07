import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_typography.dart';

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.slate900,
      primaryColor: AppColors.navy700,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.navy700,
        secondary: AppColors.navy900,
        surface: AppColors.slate800,
        onSurface: AppColors.white,
        onSurfaceVariant: AppColors.slate500,
        outline: AppColors.slate500,
        error: AppColors.errorRed,
      ),
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.slate800,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.slate500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.slate500),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.navy700, width: 1.5),
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
          borderSide: BorderSide(color: AppColors.slate500.withValues(alpha: 0.3)),
        ),
      ),
    );
