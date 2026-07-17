import 'package:flutter/material.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';

class DatePickerHelper {
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: AppColors.whiteColor,
              onSurface: AppColors.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
