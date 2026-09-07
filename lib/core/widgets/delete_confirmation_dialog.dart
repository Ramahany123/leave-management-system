import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/outlined_button_widget.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? confirmText;
  final String? cancelText;

  const DeleteConfirmationDialog({
    super.key,
    required this.message,
    this.title,
    this.cancelText,
    this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: context.colorScheme.surface,
      contentPadding: EdgeInsets.all(24.r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Red Trash Icon Badge
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.error.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.delete_outline,
              color: context.colorScheme.error,
              size: 32.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // 2. Dialog Title
          Text(
            title ?? "Confirm Delete",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          // 3. Message
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 24.h),

          // 4. Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButtonWidget(
                  height: 48.h,
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelText ?? "Cancel",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButtonWidget(
                  height: 48.h,
                  backgroundColor: context.colorScheme.error,
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    confirmText ?? "Delete",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
