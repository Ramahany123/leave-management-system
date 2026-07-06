import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/core/widgets/leave_requests_sliver_list.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_history_cubit.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_request_details_cubit.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/history_empty_state.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/leave_history_shimmer.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/request_details_bottom_sheet.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/request_status_filter_widget.dart';

class LeaveHistoryScreen extends StatelessWidget {
  const LeaveHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LeaveHistoryCubit, LeaveHistoryState>(
          builder: (context, state) {
            final leaveHistoryCubit = context.read<LeaveHistoryCubit>();
            return switch (state) {
              LeaveHistoryLoading() => LeaveHistoryShimmer(),
              LeaveHistoryError(failure: final f) => GeneralErrorWidget(
                message: f.message,
                onRetry: leaveHistoryCubit.getLeaveHistory,
              ),
              LeaveHistorySuccess(
                leaveHistoryRequests: final leaveRequests,
                selectedStatus: final status,
              ) =>
                RefreshIndicator(
                  onRefresh: () async {
                    await leaveHistoryCubit.getLeaveHistory();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 24.h,
                          ),
                          child: RequestStatusFilterWidget(
                            activeStatus: status,
                          ),
                        ),
                      ),
                      if (leaveRequests.isEmpty)
                        HistoryEmptyState()
                      else
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          sliver: LeaveRequestsSliverList(
                            leaveRequests: leaveRequests,
                            onRequestTapped: (request) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      sl<LeaveRequestDetailsCubit>()
                                        ..getLeaveRequestDetails(
                                          request.requestId,
                                        ),
                                  child: RequestDetailsBottomSheet(
                                    requestId: request.requestId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
