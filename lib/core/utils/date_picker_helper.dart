import 'package:flutter/material.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class DatePickerHelper {
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 30)),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      builder: (datePickerContext, child) {
        return Theme(data: context.theme, child: child!);
      },
    );
  }

  static Future<DateTimeRange?> pickDateRange(
    BuildContext context, {
    DateTimeRange<DateTime>? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(2024),
      lastDate: lastDate ?? DateTime.now().add(Duration(days: 365)),
      initialDateRange: initialDateRange,
    );
  }
}
