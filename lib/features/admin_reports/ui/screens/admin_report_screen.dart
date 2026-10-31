import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/empty_state_widget.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/departments_cubit.dart';
import 'package:leave_management_system/features/admin_reports/logic/cubit/report_cubit.dart';

import '../widgets/load_more_error_footer.dart';
import '../widgets/report_filter_bar.dart';
import '../widgets/report_list_shimmer.dart';
import '../widgets/report_request_card.dart';

class AdminReportScreen extends StatelessWidget {
  const AdminReportScreen({super.key});

  Map<int, String> _departmentOptions(DepartmentsState state) {
    return switch (state) {
      DepartmentsSuccess(:final departments) => {
        for (final department in departments)
          department.departmentId: department.departmentName,
      },
      _ => const <int, String>{},
    };
  }

  Map<int, String> _leaveTypeOptions(LeaveTypeState state) {
    return {
      for (final leaveType in state.leaveTypesList)
        leaveType.typeId: leaveType.typeName,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.admin_reports_title.tr())),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // 1. Filter bar — rebuilds ONLY when the query changes.
              BlocSelector<ReportCubit, ReportState, (String?, bool)>(
                selector: (state) => (
                  state.query.status,
                  state.query.departmentId != null ||
                      state.query.typeId != null ||
                      state.query.startDate != null ||
                      state.query.endDate != null,
                ),
                builder: (context, filter) {
                  final reportCubit = context.read<ReportCubit>();
                  final (status, hasActiveFilters) = filter;
                  return ReportFilterBar(
                    selectedStatus: status,
                    hasActiveFilters: hasActiveFilters,
                    onStatusSelected: (newStatus) {
                      reportCubit.changeStatusFilter(newStatus);
                    },
                    onOpenFilters: () async {
                      final filteredQuery =
                          await AppDialogs.showReportFilterSheet(
                            context,
                            departments: _departmentOptions(
                              context.read<DepartmentsCubit>().state,
                            ),
                            leaveTypes: _leaveTypeOptions(
                              context.read<LeaveTypeCubit>().state,
                            ),
                            initialQuery: reportCubit.reportQuery,
                          );
                      if (filteredQuery != null && context.mounted) {
                        reportCubit.applyQuery(filteredQuery);
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 2. List area — must be Expanded inside a Column.
              Expanded(
                child: BlocConsumer<ReportCubit, ReportState>(
                  listenWhen: (previous, current) =>
                      previous.refreshFailure != current.refreshFailure,
                  listener: (context, state) {
                    final refreshFailure = state.refreshFailure;
                    if (refreshFailure != null) {
                      showAnimatedSnakDialogue(
                        context,
                        type: AnimatedSnackBarType.error,
                        message: refreshFailure.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    final reportCubit = context.read<ReportCubit>();
                    if (state.isInitialLoading) {
                      return const ReportListShimmer();
                    }

                    final failure = state.initialFailure;
                    if (failure != null) {
                      return GeneralErrorWidget(
                        message: failure.message,
                        onRetry: () => reportCubit.applyQuery(state.query),
                      );
                    }

                    if (state.requests.isEmpty) {
                      final hasActiveFilters =
                          state.query.status != null ||
                          state.query.departmentId != null ||
                          state.query.typeId != null ||
                          state.query.startDate != null;
                      return EmptyStateWidget(
                        message: hasActiveFilters
                            ? LocaleKeys.admin_reports_no_reports_found.tr()
                            : LocaleKeys.admin_reports_empty_title.tr(),
                        subtitle: hasActiveFilters
                            ? null
                            : LocaleKeys.admin_reports_empty_message.tr(),
                        icon: Icons.assignment_outlined,
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: reportCubit.refreshReports,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification) {
                            if (notification.metrics.extentAfter < 300) {
                              reportCubit.loadMoreReports();
                            }
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: EdgeInsetsDirectional.only(
                            top: 16.h,
                            bottom: 24.h,
                          ),
                          itemCount:
                              state.requests.length +
                              (state.isLoadingMore ||
                                      state.loadMoreFailure != null
                                  ? 1
                                  : 0),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            if (index >= state.requests.length) {
                              if (state.loadMoreFailure != null) {
                                return LoadMoreErrorFooter(
                                  onRetry: () => context
                                      .read<ReportCubit>()
                                      .loadMoreReports(),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }
                            return ReportRequestCard(
                              request: state.requests[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
