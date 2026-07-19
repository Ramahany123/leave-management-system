import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class DocumentUploadCard extends StatelessWidget {
  final String docName;
  final String? fileName;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final bool isEnabled;

  const DocumentUploadCard({
    super.key,
    required this.docName,
    required this.fileName,
    required this.onTap,
    this.onRemove,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUploaded = fileName != null;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isUploaded
              ? AppColors.successGreen
              : context.colorScheme.outline,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isUploaded ? Icons.check_circle : Icons.upload_file_rounded,
            color: isUploaded ? AppColors.successGreen : context.colorScheme.primary,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(docName, style: context.textTheme.titleSmall),
                SizedBox(height: 2.h),
                Text(
                  isUploaded
                      ? fileName!.split('/').last
                      : LocaleKeys.leave_request_no_document_selected.tr(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isUploaded
                        ? AppColors.successGreen
                        : context.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: isEnabled
                ? (isUploaded ? (onRemove ?? onTap) : onTap)
                : null,
            style: TextButton.styleFrom(
              foregroundColor: isUploaded
                  ? AppColors.errorRed
                  : context.colorScheme.primary,
            ),
            child: Text(
              isUploaded
                  ? LocaleKeys.leave_request_remove.tr()
                  : LocaleKeys.leave_request_upload_file.tr(),
              style: context.textTheme.labelMedium?.copyWith(
                color: isUploaded
                    ? AppColors.errorRed
                    : context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
