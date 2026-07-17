import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

//TODO: localize text
class SignatureWarningCard extends StatelessWidget {
  final VoidCallback onUploadPressed;

  const SignatureWarningCard({super.key, required this.onUploadPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        // Soft red background indicating warning
        color: AppColors.errorRed.withValues(alpha: 0.08),
        border: Border.all(
          color: AppColors.errorRed.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.errorRed,
              ),
              SizedBox(width: 8.w),
              Text(
                "Electronic Signature Required",
                style: AppTextStyles.black16w600TextStyle.copyWith(
                  color: AppColors.errorRed,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "You cannot submit leave requests until you upload your electronic signature. Please go to your profile settings to upload it.",
            style: AppTextStyles.grey14w400TextStyle.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton.icon(
            onPressed: onUploadPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              elevation: 0,
            ),
            icon: Icon(Icons.edit_document, color: Colors.white, size: 18.sp),
            label: Text(
              "Upload Signature Now",
              style: AppTextStyles.white14w500TextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
