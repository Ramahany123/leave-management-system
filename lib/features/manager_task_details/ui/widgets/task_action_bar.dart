import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/manager_task_details/logic/cubit/task_approval_action_cubit.dart';

import '../../data/models/task_detail_model.dart';

class TaskActionBar extends StatelessWidget {
  final TaskDetailsModel taskDetails;
  const TaskActionBar({super.key, required this.taskDetails});

  _onAcceptPressed(BuildContext context) {
    final role = ApprovalRole.fromString(taskDetails.roleAtApproval);
    if (role.isCouncil) {
      AppDialogs.showCouncilSessionDialog(context, (
        sessionNumber,
        sessionDate,
        commments,
      ) {
        context.read<TaskApprovalActionCubit>().approveTask(
          taskDetails.taskId,
          comments: commments,
          sessionNumber: sessionNumber,
          sessionDate: sessionDate,
        );
      });
    } else {
      context.read<TaskApprovalActionCubit>().approveTask(taskDetails.taskId);
    }
  }

  _onRejectPressed(BuildContext context) {
    AppDialogs.showRejectionReasonDialog(context, (reason) {
      context.read<TaskApprovalActionCubit>().rejectTask(
        taskDetails.taskId,
        reason,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: BlocConsumer<TaskApprovalActionCubit, TaskApprovalActionState>(
        listener: (context, state) {
          if (state is TaskApprovalSuccess) {
            showAnimatedSnakDialogue(
              context,
              message: "Action Completed Successfully",
            );
            if (context.mounted) {
              context.pop();
            }
          } else if (state is TaskApprovalError) {
            showAnimatedSnakDialogue(
              context,
              message: state.failure.message,
              type: AnimatedSnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is TaskApprovalLoading;
          return Row(
            children: [
              Expanded(
                child: PrimaryButtonWidget(
                  isLoading: isLoading,
                  onPressed: () {
                    _onAcceptPressed(context);
                  },
                  backgroundColor: context.colorScheme.primaryContainer,
                  child: Text(
                    "Accept",
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PrimaryButtonWidget(
                  isLoading: isLoading,
                  onPressed: () {
                    _onRejectPressed(context);
                  },
                  backgroundColor: context.colorScheme.errorContainer,
                  child: Text(
                    "Reject",
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
