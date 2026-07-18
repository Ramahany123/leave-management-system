import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class CustomBottomSheetShell extends StatelessWidget {
  final String title;
  final Widget content;
  const CustomBottomSheetShell({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          content,
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
