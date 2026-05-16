import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/employee_dashboard/logic/cubit/employee_dashboard_cubit.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/dashboard_shimmer.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/employee_header.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/leave_balances_list.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/recent_requests_list.dart';

import '../../../../core/routes/app_routes.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EmployeeHeader(),
              SizedBox(height: 32.h),
              BlocBuilder<EmployeeDashboardCubit, EmployeeDashboardState>(
                builder: (context, state) {
                  return switch (state) {
                    EmployeeDashboardLoading() => DashboardShimmer(),

                    EmployeeDashboardSuccess(
                      employeeDashboardResponse: final data,
                    ) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            LocaleKeys.dashboard_leave_balance.tr(),
                            style: AppTextStyles.primaryBlue20w600TextStyle,
                          ),
                          SizedBox(height: 16.h),
                          LeaveBalancesList(leaveBalances: data.leaveBalances),
                          SizedBox(height: 32.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.dashboard_recent_requests.tr(),
                                style: AppTextStyles.primaryBlue20w600TextStyle,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.leaveHistoryScreen);
                                },
                                child: Text(
                                  LocaleKeys.dashboard_view_all.tr(),
                                  style: AppTextStyles.primary14w600TextStyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          RecentRequestsList(
                            recentRequests: data.recentRequests,
                          ),
                          SizedBox(height: 80.h),
                        ],
                      ), // Padding for FAB

                    EmployeeDashboardError(failure: final f) =>
                      GeneralErrorWidget(
                        message: f.message,
                        onRetry: context
                            .read<EmployeeDashboardCubit>()
                            .getEmployeeDashboard,
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
