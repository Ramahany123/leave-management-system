import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/leave_request_model.dart';
import '../utils/request_status_extension.dart';
import 'leave_request_card.dart';

class LeaveRequestsSliverList extends StatelessWidget {
  final List<LeaveRequestModel> leaveRequests;
  const LeaveRequestsSliverList({super.key, required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: leaveRequests.length,
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
