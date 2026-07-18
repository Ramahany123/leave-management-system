import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class GeneralErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const GeneralErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Try Again',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
