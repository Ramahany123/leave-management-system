import 'package:flutter/widgets.dart';
import 'package:leave_management_system/core/widgets/approval_step_tile.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/features/manager_task_details/data/models/task_detail_model.dart';

class TaskApprovalTimeline extends StatelessWidget {
  final TaskDetailsModel taskDetails;
  const TaskApprovalTimeline({super.key, required this.taskDetails});

  @override
  Widget build(BuildContext context) {
    final steps = taskDetails.history;
    if (steps.isEmpty) return const SizedBox.shrink();
    return InfoSection(
      title: "Approval Timeline",
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            return ApprovalStepTile(
              isLast: index == steps.length - 1,
              status: step.status,
              displayName: step.approver,
              roleAtApproval: step.role,
              comments: step.comments,
              sessionNumber: step.sessionNumber,
              sessionDate: step.sessionDate,
            );
          },
        ),
      ],
    );
  }
}
