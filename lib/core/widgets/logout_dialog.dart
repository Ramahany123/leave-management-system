import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'outlined_button_widget.dart';
import 'primary_button_widget.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      backgroundColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.all(24.r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.errorRed.withValues(alpha: 0.1),
            ),
            child: Icon(Icons.logout, color: AppColors.errorRed, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          // Text
          Text("Logout", style: AppTextStyles.black20w600TextStyle),
          SizedBox(height: 8.h),
          Text(
            "Are you sure you want to log out of your account?",
            textAlign: TextAlign.center,
            style: AppTextStyles.grey14w400TextStyle,
          ),
          SizedBox(height: 24.h),
          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButtonWidget(
                  height: 48.h,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: AppTextStyles.primary14w600TextStyle,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButtonWidget(
                  height: 48.h,
                  backgroundColor: AppColors.errorRed,
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  child: Text(
                    "Logout",
                    style: AppTextStyles.white14w500TextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
