import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_context_extension.dart';

class AttachmentsFileCard extends StatelessWidget {
  final String fileName;
  final VoidCallback? onView;
  const AttachmentsFileCard({super.key, required this.fileName, this.onView});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(Icons.document_scanner, color: context.colorScheme.primary),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium,
            ),
          ),
          SizedBox(width: 12.w),
          IconButton(
            onPressed: onView,
            icon: Icon(
              Icons.remove_red_eye,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
