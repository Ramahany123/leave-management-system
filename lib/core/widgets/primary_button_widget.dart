import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const PrimaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        fixedSize: Size(331.w, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.r),
        ),
      ),
      child: Text(text, style: AppTextStyles.white16w600TextStyle),
    );
  }
}
