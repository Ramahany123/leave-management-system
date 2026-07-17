import 'package:flutter/material.dart';
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
    );
