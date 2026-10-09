import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/leave_type_options.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';

class LeaveTypeCard extends StatelessWidget {
  final LeaveType leaveType;
  final bool isDeleting;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LeaveTypeCard({
    super.key,
    required this.leaveType,
    this.isDeleting = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  String _label(String raw) {
    final text = LeaveTypeOptions.displayLabel(raw);
    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsetsDirectional.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.event_note_outlined,
                        color: context.colorScheme.primary,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            leaveType.typeName,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            leaveType.category ?? "Uncategorized",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _buildStatusBadge(context),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          _buildTag(
                            context,
                            label: _label(leaveType.balanceType),
                            icon: Icons.account_balance_outlined,
                            isPrimary: true,
                          ),
                          _buildTag(
                            context,
                            label: leaveType.isPaid ? "Paid" : "Unpaid",
                            icon: Icons.payments_outlined,
                          ),
                          _buildTag(
                            context,
                            label:
                                "${leaveType.workflow.length} "
                                "${leaveType.workflow.length == 1 ? "step" : "steps"}",
                            icon: Icons.account_tree_outlined,
                          ),
                          _buildTag(
                            context,
                            label:
                                "${leaveType.requiredDocuments.length} "
                                "${leaveType.requiredDocuments.length == 1 ? "document" : "documents"}",
                            icon: Icons.attach_file_outlined,
                          ),
                        ],
                      ),
                    ),
                    if (onEdit != null) ...[
                      SizedBox(width: 8.w),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: context.colorScheme.primary,
                          size: 20.sp,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: isDeleting ? null : onEdit,
                      ),
                    ],
                    if (onDelete != null) ...[
                      SizedBox(width: 8.w),
                      if (isDeleting)
                        SizedBox(
                          width: 22.w,
                          height: 22.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: context.colorScheme.error,
                          ),
                        )
                      else
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: context.colorScheme.error,
                            size: 20.sp,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onDelete,
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final bool isActive = leaveType.isActive;
    final Color badgeColor = isActive
        ? AppColors.successGreen
        : context.colorScheme.error;

    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        isActive ? "Active" : "Inactive",
        style: context.textTheme.labelSmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTag(
    BuildContext context, {
    required String label,
    required IconData icon,
    bool isPrimary = false,
  }) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPrimary
            ? context.colorScheme.primary.withValues(alpha: 0.08)
            : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isPrimary
              ? context.colorScheme.primary.withValues(alpha: 0.25)
              : context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.sp,
            color: isPrimary
                ? context.colorScheme.primary
                : context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 4.w),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 140.w),
            child: Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: isPrimary
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
                fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
