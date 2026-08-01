import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/widgets/leave_request_card.dart';
import 'package:leave_management_system/features/manager_dashboard/data/models/pending_approval_model.dart';

import '../../../../core/theme/theme_context_extension.dart';

class PendingApprovalList extends StatelessWidget {
  final List<PendingApprovalModel> pendingApprovals;

  final void Function(PendingApprovalModel pendingTask)? onTaskTapped;
  const PendingApprovalList({
    super.key,
    required this.pendingApprovals,
    this.onTaskTapped,
  });
  @override
  Widget build(BuildContext context) {
    if (pendingApprovals.isEmpty) {
      return _buildEmptyState(context);
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final task = pendingApprovals[index];
        final request = task.request;
        return LeaveRequestCard(
          title: "${request.user.name} • ${request.leaveTypeName}",
          date:
              "${DateFormat("MMM dd").format(request.startDate)} - ${DateFormat("MMM dd").format(request.endDate)}",
          status: request.status,
          onTap: () => onTaskTapped?.call(task),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: pendingApprovals.length,
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 16.h),
        Icon(
          Icons.description_outlined,
          size: 64.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
        SizedBox(height: 16.h),
        Text(
          LocaleKeys.manager_dashboard_no_requests.tr(),
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );
}
