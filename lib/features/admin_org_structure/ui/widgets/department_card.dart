import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_departements_model.dart';

enum DepartmentMenuAction { edit, delete }

class DepartmentCard extends StatelessWidget {
  final Department department;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DepartmentCard({
    super.key,
    required this.department,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(department.departmentId),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) => onEdit(),
            backgroundColor: context.colorScheme.primaryContainer,
            foregroundColor: context.colorScheme.onPrimary,
            icon: Icons.edit_outlined,
            label: "Edit",
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16.r)),
          ),
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: context.colorScheme.errorContainer,
            foregroundColor: context.colorScheme.onError,
            icon: Icons.delete_outline,
            label: "Delete",
            borderRadius: BorderRadius.horizontal(right: Radius.circular(16.r)),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colorScheme.outline.withAlpha(50)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== HEADER ROW ====================
            Row(
              children: [
                Icon(
                  Icons.business_outlined,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    department.departmentName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 20.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case DepartmentMenuAction.edit:
                        onEdit();
                      case DepartmentMenuAction.delete:
                        onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<DepartmentMenuAction>(
                      value: DepartmentMenuAction.edit,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 18.sp,
                            color: context.colorScheme.primary,
                          ),
                          SizedBox(width: 8.w),
                          Text("Edit", style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    PopupMenuItem<DepartmentMenuAction>(
                      value: DepartmentMenuAction.delete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 18.sp,
                            color: context.colorScheme.error,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Delete",
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // ==================== MIDDLE (Head of Dept) ====================
            Row(
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 18.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Head: ${department.head?.name ?? 'No Head assigned'}",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // ==================== FOOTER (Parent College Badge) ====================
            if (department.college != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance_outlined,
                      size: 14.sp,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      department.college!.collegeName,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
