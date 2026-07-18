import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class CustomDateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final String hint;
  final VoidCallback? onTap;
  final bool isEnabled;

  const CustomDateSelector({
    super.key,
    this.selectedDate,
    required this.hint,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final String displayText = selectedDate != null
        ? selectedDate!.toIso8601String().split("T").first
        : hint;
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isEnabled ? context.colorScheme.surface : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isEnabled ? context.colorScheme.outline : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: context.textTheme.bodyMedium?.copyWith(
                color: selectedDate != null
                    ? context.colorScheme.onSurface
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: isEnabled ? context.colorScheme.primary : Colors.grey.shade400,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
