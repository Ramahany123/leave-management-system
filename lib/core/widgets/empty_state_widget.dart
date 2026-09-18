import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? subtitle;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.iconSize,
    this.iconColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor =
        iconColor ??
        context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 88.h,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface.withValues(alpha: 0.04),
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.outline.withValues(alpha: 0.15),
                ),
              ),
              child: Icon(
                icon,
                size: iconSize ?? 42.sp,
                color: effectiveIconColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
            if (action != null) ...[
              SizedBox(height: 20.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
