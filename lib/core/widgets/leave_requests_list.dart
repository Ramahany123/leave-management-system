import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/models/leave_request_model.dart';
import 'package:leave_management_system/core/utils/request_status_extension.dart';
import 'package:leave_management_system/core/widgets/leave_request_card.dart';

class LeaveRequestsList extends StatelessWidget {
  final List<LeaveRequestModel> leaveRequests;
  const LeaveRequestsList({super.key, required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      itemCount: leaveRequests.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final request = leaveRequests[index];
        return LeaveRequestCard(
          title: request.leaveTypeName,
          date:
              '${DateFormat('MMM dd').format(request.startDate)} - ${DateFormat('MMM dd, yyyy').format(request.endDate)}',
          status: request.status,
          statusColor: request.status.getStatusColor,
          statusBgColor: request.status.getStatusColor.withValues(alpha: 0.1),
          statusIcon: request.status.getStatusIcon,
        );
      },
    );
  }
}
