import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class LoadMoreErrorFooter extends StatelessWidget {
  final VoidCallback onRetry;

  const LoadMoreErrorFooter({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 16.sp, color: color.error),
          SizedBox(width: 8.w),
          Text(
            LocaleKeys.admin_reports_load_more_failed.tr(),
            style: context.textTheme.bodySmall?.copyWith(color: color.outline),
          ),
          SizedBox(width: 4.w),
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 20.sp,
            color: color.primary,
            tooltip: LocaleKeys.common_try_again.tr(),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
