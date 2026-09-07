import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';

import '../../../../core/utils/service_locator.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = sl<AuthRepo>().userName;

    return Row(
      children: [
        NameAvatar(name: name),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.admin_dashboard_welcome.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                name,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: context.colorScheme.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.admin_panel_settings_rounded,
                      size: 14.sp,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      LocaleKeys.admin_dashboard_role_badge.tr(),
                      style: context.textTheme.labelSmall?.copyWith(
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
                onPressed: () {
                  // Will be implemented later
                },
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
                tooltip: LocaleKeys.navigation_profile.tr(),
                onPressed: () => context.push(AppRoutes.adminProfileScreen),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
