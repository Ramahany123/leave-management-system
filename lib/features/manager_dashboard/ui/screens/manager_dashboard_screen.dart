import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/core/widgets/user_header.dart';
import 'package:leave_management_system/features/manager_dashboard/logic/cubit/manager_dashboard_cubit.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/widgets/manager_dashboard_shimmer.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/widgets/manager_stats_card.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/widgets/pending_approval_list.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/theme_context_extension.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

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
            mainAxisSize: MainAxisSize.min,
            children: [
              UserHeader(),
              SizedBox(height: 32.h),
              BlocBuilder<ManagerDashboardCubit, ManagerDashboardState>(
                builder: (context, state) {
                  return switch (state) {
                    ManagerDashboardLoading() => ManagerDashboardShimmer(),

                    ManagerDashboardError(:final failure) => GeneralErrorWidget(
                      message: failure.message,
                      onRetry: context
                          .read<ManagerDashboardCubit>()
                          .getManagerDashboard,
                    ),

                    ManagerDashboardSuccess(
                      managerDashboardModel: final data,
                    ) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ManagerStatsCard(
                                  title: LocaleKeys
                                      .manager_dashboard_pending_approvals
                                      .tr(),
                                  subTitle: LocaleKeys
                                      .manager_dashboard_awaiting_signature
                                      .tr(),
                                  statsNumber: data.totalPendingTasks,
                                  icon: Icons.edit_document,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: ManagerStatsCard(
                                  title: LocaleKeys
                                      .manager_dashboard_team_on_leave
                                      .tr(),
                                  subTitle: LocaleKeys
                                      .manager_dashboard_currently_absent
                                      .tr(),
                                  statsNumber:
                                      0, // Placeholder until Coverage feature
                                  icon: Icons.people_outline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.manager_dashboard_awaiting_review
                                    .tr(),
                                style: context.textTheme.titleLarge?.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.managerCoverageScreen);
                                },
                                child: Text(
                                  LocaleKeys.dashboard_view_all.tr(),
                                  style: context.textTheme.titleSmall?.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          PendingApprovalList(
                            pendingApprovals: data.pendingApprovals,
                            onTaskTapped: (task) async {
                              await AppDialogs.showTaskDetailsSheet(
                                context,
                                task.stepId,
                              );
                              if (context.mounted) {
                                context
                                    .read<ManagerDashboardCubit>()
                                    .getManagerDashboard();
                              }
                            },
                          ),
                          SizedBox(height: 80.h),
                        ],
                      ),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
