import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const OutlinedButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(331.w, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.r),
          side: BorderSide(width: 2.w, color: AppColors.primaryBlue),
        ),
      ),
      child: Text(text, style: AppTextStyles.black16w500TextStyle),
    );
  }
}
