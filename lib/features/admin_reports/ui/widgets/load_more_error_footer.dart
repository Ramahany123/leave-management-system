import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            'Failed to load more reports',
            style: TextStyle(fontSize: 12.sp, color: color.outline),
          ),
          SizedBox(width: 4.w),
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 20.sp,
            color: color.primary,
            tooltip: 'Retry',
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
