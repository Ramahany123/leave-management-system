import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

class DocumentUploadCard extends StatelessWidget {
  final String docName;
  final String? fileName;
  final VoidCallback onTap;
  final bool isEnabled;

  const DocumentUploadCard({
    super.key,
    required this.docName,
    required this.fileName,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUploaded = fileName != null;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          // Change border color to green when uploaded successfully
          color: isUploaded
              ? AppColors.successGreen
              : AppColors.cardBorderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // 1. Dynamic Status Icon
          Icon(
            isUploaded ? Icons.check_circle : Icons.upload_file_rounded,
            color: isUploaded ? AppColors.successGreen : AppColors.primaryBlue,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),

          // 2. Document Details (Name & Filename)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(docName, style: AppTextStyles.black14w600TextStyle),
                SizedBox(height: 2.h),
                Text(
                  // Safely extract the filename from the absolute path
                  isUploaded
                      ? fileName!.split('/').last
                      : "No document selected",
                  style: AppTextStyles.grey12w500TextStyle.copyWith(
                    color: isUploaded
                        ? AppColors.successGreen
                        : AppColors.greyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // 3. Dynamic Action Button (Upload / Remove)
          TextButton(
            onPressed: isEnabled ? onTap : null,
            style: TextButton.styleFrom(
              foregroundColor: isUploaded
                  ? AppColors.errorRed
                  : AppColors.primaryBlue,
            ),
            child: Text(
              isUploaded ? "Remove" : "Upload File",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
