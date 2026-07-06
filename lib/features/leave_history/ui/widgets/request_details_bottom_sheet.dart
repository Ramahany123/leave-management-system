import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/models/leave_request_details_model.dart';
import 'package:leave_management_system/core/widgets/build_info_section.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_request_details_cubit.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/request_details_shimmer.dart';

import '../../../../core/utils/date_extension.dart';
import '../../../../core/widgets/general_error_widget.dart';
import '../../../../core/widgets/key_value_row_widget.dart';

class RequestDetailsBottomSheet extends StatelessWidget {
  final int requestId;
  const RequestDetailsBottomSheet({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetShell(
      //TODO: localize text
      title: "Leave Request Details",
      content: Flexible(
        child: BlocBuilder<LeaveRequestDetailsCubit, LeaveRequestDetailsState>(
          builder: (context, state) {
            return switch (state) {
              LeaveRequestDetailsInitial() ||
              LeaveRequestDetailsLoading() => RequestDetailsShimmer(),
              LeaveRequestDetailsError(failure: final f) => Center(
                child: GeneralErrorWidget(
                  message: f.message,
                  onRetry: () => context
                      .read<LeaveRequestDetailsCubit>()
                      .getLeaveRequestDetails(requestId),
                ),
              ),
              LeaveRequestDetailsSuccess(
                leaveRequestDetails: final leaveRequestDetails,
              ) =>
                _buildBottomSheetContent(leaveRequestDetails),
            };
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent(
    LeaveRequestDetailsModel leaveRequestDetails,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SECTION 1: General Leave Information
          buildInfoSection("LEAVE INFORMATION", [
            KeyValueRow(
              label: "Type",
              value: leaveRequestDetails.leaveType.typeName,
            ),
            KeyValueRow(label: "Status", value: leaveRequestDetails.status),
            KeyValueRow(
              label: "Duration",
              value: "${leaveRequestDetails.duration} Days",
            ),
            KeyValueRow(label: "Reason", value: leaveRequestDetails.reason),
          ]),
          SizedBox(height: 24.h),

          // SECTION 2: Dates & Timing
          buildInfoSection("TIMING DETAILS", [
            KeyValueRow(
              label: "Start Date",
              value: leaveRequestDetails.startDate.toReadableDate,
            ),
            KeyValueRow(
              label: "End Date",
              value: leaveRequestDetails.endDate.toReadableDate,
            ),
            // Only show "Returned At" if the user actually returned
            if (leaveRequestDetails.returnedAt != null)
              KeyValueRow(
                label: "Returned At",
                value: leaveRequestDetails.returnedAt!.toReadableDate,
              ),
            KeyValueRow(
              label: "Applied On",
              value: leaveRequestDetails.createdAt.toReadableDate,
            ),
          ]),
          SizedBox(height: 24.h),

          // SECTION 3: Additional & Technical Info
          buildInfoSection("ADDITIONAL DETAILS", [
            KeyValueRow(
              label: "Pre-Leave Ack.",
              value: leaveRequestDetails.preLeaveAcknowledgement
                  ? "Completed"
                  : "Pending",
            ),
            // Display attachment count rather than printing a raw list
            //TODO: implement pdf viewer
            KeyValueRow(
              label: "Attachments",
              value: "${leaveRequestDetails.attachments.length} File(s)",
            ),
            // Only show Delegate info if someone was delegated
            if (leaveRequestDetails.delegateUserId != null)
              KeyValueRow(
                label: "Delegate ID",
                value: leaveRequestDetails.delegateUserId.toString(),
              ),
            KeyValueRow(
              label: "Approval Steps",
              value: "${leaveRequestDetails.approvalSteps.length} Step(s)",
            ),
          ]),
        ],
      ),
    );
  }
}
