import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';

class AdminUserCard extends StatelessWidget {
  final AdminUserModel user;
  final bool isDeleting;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const AdminUserCard({
    super.key,
    required this.user,
    this.isDeleting = false,
    this.onDelete,
    this.onTap,
  });

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
                    NameAvatar(name: user.name),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            user.jobTitle ?? user.role,
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
                    Icon(
                      Icons.email_outlined,
                      size: 14.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        user.email,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          _buildTag(
                            context,
                            label: user.role,
                            icon: Icons.badge_outlined,
                            isRole: true,
                          ),
                          if (user.department != null &&
                              user.department!.isNotEmpty)
                            _buildTag(
                              context,
                              label: user.department!,
                              icon: Icons.business_outlined,
                            ),
                          if (user.college != null && user.college!.isNotEmpty)
                            _buildTag(
                              context,
                              label: user.college!,
                              icon: Icons.account_balance_outlined,
                            ),
                        ],
                      ),
                    ),
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
    final bool isActive = user.isActive;
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
    bool isRole = false,
  }) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isRole
            ? context.colorScheme.primary.withValues(alpha: 0.08)
            : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isRole
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
            color: isRole
                ? context.colorScheme.primary
                : context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 4.w),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 140.w),
            child: Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: isRole
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
                fontWeight: isRole ? FontWeight.w600 : FontWeight.normal,
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
