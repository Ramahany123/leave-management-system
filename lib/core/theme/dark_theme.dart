import 'package:flutter/material.dart';
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
    );
