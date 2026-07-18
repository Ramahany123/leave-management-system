import 'package:flutter/material.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

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
      builder: (datePickerContext, child) {
        return Theme(
          data: context.theme,
          child: child!,
        );
      },
    );
  }
}
