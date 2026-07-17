import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

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
          // Mimics text fields and dropdowns
          color: isEnabled ? AppColors.whiteColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isEnabled ? AppColors.cardBorderColor : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: selectedDate != null
                  ? AppTextStyles.black14w500TextStyle
                  : AppTextStyles.grey14w400TextStyle,
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: isEnabled ? AppColors.primaryBlue : Colors.grey.shade400,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
