import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/manager_reports_shimmer.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_empty_state.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_filter_bar.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_search_bar.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_statistics_grid.dart';

import '../../logic/cubit/manager_report_cubit.dart';
import '../widgets/report_items_list.dart';

class ManageReportsScreen extends StatelessWidget {
  const ManageReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reportCubit = context.read<ManagerReportCubit>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: BlocBuilder<ManagerReportCubit, ManagerReportState>(
            builder: (context, state) {
              final (
                reportModel,
                currentRange,
                currentStatus,
              ) = switch (state) {
                ManagerReportSuccess(
                  :final managerReportsModel,
                  :final selectedRange,
                  :final selectedStatus,
                ) =>
                  (managerReportsModel, selectedRange, selectedStatus),
                _ => (
                  reportCubit.currentReportModel,
                  reportCubit.selectedDateRange,
                  reportCubit.selectedStatus,
                ),
              };

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReportFilterBar(
                    selectedRange: currentRange,
                    selectedStatus: currentStatus,
                  ),
                  ReportStatisticsGrid(stats: reportModel?.statistics),
                  ReportSearchBar(),
                  switch (state) {
                    ManagerReportLoading() => ManagerReportsShimmer(),
                    ManagerReportError(:final failure) => GeneralErrorWidget(
                      message: failure.message,
                      onRetry: context
                          .read<ManagerReportCubit>()
                          .getManagerReports,
                    ),
                    ManagerReportSuccess(:final filteredReports) =>
                      filteredReports.isEmpty
                          ? ReportEmptyState()
                          : ReportItemsList(filteredReports: filteredReports),
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
