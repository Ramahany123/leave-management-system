import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/core/widgets/key_value_row_widget.dart';
import 'package:leave_management_system/features/manager_task_details/logic/cubit/task_approval_action_cubit.dart';
import 'package:leave_management_system/features/manager_task_details/logic/cubit/task_details_cubit.dart';
import 'package:leave_management_system/features/manager_task_details/ui/widgets/task_action_bar.dart';
import 'package:leave_management_system/features/manager_task_details/ui/widgets/task_approval_timeline.dart';
import 'package:leave_management_system/features/manager_task_details/ui/widgets/task_details_shimmer.dart';
import 'package:leave_management_system/features/manager_task_details/ui/widgets/task_employee_balance_card.dart';
import 'package:leave_management_system/features/manager_task_details/ui/widgets/task_leave_info_section.dart';
import '../../../../core/widgets/custom_bottom_sheet_shell.dart';

//TODO: localize text
class TaskDetailsBottomSheet extends StatelessWidget {
  final int stepId;
  const TaskDetailsBottomSheet({super.key, required this.stepId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskApprovalActionCubit, TaskApprovalActionState>(
      builder: (context, state) {
        final isLoading = state is TaskApprovalLoading;
        return PopScope(
          canPop: !isLoading,
          child: CustomBottomSheetShell(
            title: 'Task Details',
            content: Flexible(
              child: SingleChildScrollView(
                child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                  builder: (context, state) {
                    switch (state) {
                      case TaskDetailsInitial() || TaskDetailsLoading():
                        return const TaskDetailsShimmer();
                      case TaskDetailsError():
                        return Center(
                          child: GeneralErrorWidget(
                            message: state.failure.message,
                            onRetry: () => context
                                .read<TaskDetailsCubit>()
                                .getTaskDetails(stepId),
                          ),
                        );
                      case TaskDetailsSuccess():
                        final taskDetails = state.taskDetails;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InfoSection(
                              title: "Requester Info",
                              children: [
                                KeyValueRow(
                                  label: "Name: ",
                                  value: taskDetails.employee.name,
                                ),
                                KeyValueRow(
                                  label: "Department: ",
                                  value: taskDetails.employee.department,
                                ),
                                KeyValueRow(
                                  label: "Email: ",
                                  value: taskDetails.employee.email,
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            TaskLeaveInfoSection(taskDetails: taskDetails),
                            SizedBox(height: 24.h),
                            TaskEmployeeBalanceCard(taskDetails: taskDetails),
                            SizedBox(height: 24.h),
                            TaskApprovalTimeline(taskDetails: taskDetails),
                            SizedBox(height: 24.h),
                            TaskActionBar(taskDetails: taskDetails),
                          ],
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
