import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

Widget buildInfoSection(BuildContext context, String title, List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12.h),
      ...children,
    ],
  );
}
