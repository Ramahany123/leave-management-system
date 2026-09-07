import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../data/models/all_colleges_model.dart';

class CollegeCard extends StatelessWidget {
  final CollegeModel college;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;
  const CollegeCard({
    super.key,
    required this.college,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorSchema = context.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: colorSchema.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colorScheme.outline.withAlpha(50)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_outlined,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    college.collegeName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: context.colorScheme.primary,
                    size: 20.sp,
                  ),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: context.colorScheme.error,
                    size: 20.sp,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Dean: ${college.dean?.name ?? 'No Dean assigned'}",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withAlpha(25),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "${college.departmentCount ?? 0} Departments",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
