import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/features/admin_dashboard/ui/widgets/admin_header.dart';
import 'package:leave_management_system/features/admin_dashboard/ui/widgets/admin_module_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdminHeader(),
              SizedBox(height: 32.h),
              Text(
                LocaleKeys.admin_dashboard_modules_section_title.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                LocaleKeys.admin_dashboard_modules_section_subtitle.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 20.h),
              AdminModuleCard(
                title: LocaleKeys.admin_dashboard_org_structure_title.tr(),
                description: LocaleKeys.admin_dashboard_org_structure_desc.tr(),
                icon: Icons.account_balance_outlined,
                onTap: () => context.push(AppRoutes.adminOrgStructureScreen),
              ),
              SizedBox(height: 14.h),
              AdminModuleCard(
                title: LocaleKeys.admin_dashboard_users_management_title.tr(),
                description: LocaleKeys.admin_dashboard_users_management_desc
                    .tr(),
                icon: Icons.people_alt_outlined,
                onTap: () {
                  // Will link to AppRoutes.adminUsersScreen in Phase 2B
                },
              ),
              SizedBox(height: 14.h),
              AdminModuleCard(
                title: LocaleKeys.admin_dashboard_leave_config_title.tr(),
                description: LocaleKeys.admin_dashboard_leave_config_desc.tr(),
                icon: Icons.rule_folder_outlined,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        LocaleKeys.admin_dashboard_upcoming_feature_notice.tr(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 14.h),
              AdminModuleCard(
                title: LocaleKeys.admin_dashboard_audit_ledger_title.tr(),
                description: LocaleKeys.admin_dashboard_audit_ledger_desc.tr(),
                icon: Icons.assignment_outlined,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        LocaleKeys.admin_dashboard_upcoming_feature_notice.tr(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
