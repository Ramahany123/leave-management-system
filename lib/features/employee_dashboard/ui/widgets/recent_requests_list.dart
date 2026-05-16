import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/recent_request_model.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/recent_request_card.dart';

class RecentRequestsList extends StatelessWidget {
  final List<RecentRequestModel> recentRequests;
  const RecentRequestsList({super.key, required this.recentRequests});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recentRequests.map((request) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: RecentRequestCard(
            title: request.leaveType.typeName,
            date:
                '${DateFormat('MMM dd').format(request.startDate)} - ${DateFormat('MMM dd, yyyy').format(request.endDate)}',
            status: request.status,
            statusColor: _getStatusColor(request.status),
            statusBgColor: _getStatusColor(
              request.status,
            ).withValues(alpha: 0.1),
            statusIcon: _getStatusIcon(request.status),
          ),
        );
      }).toList(),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case RequestStatus.approved:
      return AppColors.successGreen;
    case RequestStatus.rejected:
      return AppColors.errorRed;
    case RequestStatus.pending:
      return AppColors.pendingYellow;
    case RequestStatus.cancelled:
      return AppColors.greyColor;
    default:
      return AppColors.greyColor;
  }
}

IconData _getStatusIcon(String status) {
  switch (status) {
    case RequestStatus.approved:
      return Icons.check_circle_outline;
    case RequestStatus.rejected:
    case RequestStatus.cancelled:
      return Icons.cancel_outlined;
    case RequestStatus.pending:
      return Icons.access_time;
    default:
      return Icons.help_outline;
  }
}
