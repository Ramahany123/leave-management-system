import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'outlined_button_widget.dart';
import 'primary_button_widget.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      backgroundColor: context.colorScheme.surface,
      contentPadding: EdgeInsets.all(24.r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.errorRed.withValues(alpha: 0.1),
            ),
            child: Icon(Icons.logout, color: AppColors.errorRed, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            LocaleKeys.dialogs_logout_title.tr(),
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 8.h),
          Text(
            LocaleKeys.dialogs_logout_message.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButtonWidget(
                  height: 48.h,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    LocaleKeys.dialogs_cancel.tr(),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
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
                    LocaleKeys.dialogs_confirm_logout.tr(),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
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
