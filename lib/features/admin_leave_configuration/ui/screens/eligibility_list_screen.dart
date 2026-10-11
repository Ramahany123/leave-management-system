import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/empty_state_widget.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/eligibility_rule_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/eligibility_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/initial_loading_status.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/eligibility_group_card.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_shimmer.dart';

class EligibilityListScreen extends StatelessWidget {
  const EligibilityListScreen({super.key});

  Map<int, List<EligibilityRule>> _groupRules(List<EligibilityRule> rules) {
    final groups = <int, List<EligibilityRule>>{};
    for (final rule in rules) {
      groups.putIfAbsent(rule.leaveTypeId, () => []).add(rule);
    }
    return groups;
  }

  Future<void> _openCreateSheet(
    BuildContext context, {
    int? preselectedLeaveTypeId,
  }) async {
    final bool? isCreated = await AppDialogs.showCreateEligibilitySheet(
      context,
      preselectedLeaveTypeId: preselectedLeaveTypeId,
    );
    if (isCreated == true && context.mounted) {
      showAnimatedSnakDialogue(
        context,
        message: "Eligibility Rule Created Successfully",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eligibilityCubit = context.read<EligibilityCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Eligibility Rules")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: BlocConsumer<EligibilityCubit, EligibilityState>(
            listenWhen: (prev, curr) =>
                prev.deleteRuleFailure != curr.deleteRuleFailure ||
                prev.refreshFailure != curr.refreshFailure,
            listener: (context, state) {
              if (state.deleteRuleFailure != null) {
                showAnimatedSnakDialogue(
                  context,
                  message: state.deleteRuleFailure!.message,
                  type: AnimatedSnackBarType.error,
                );
              }
              if (state.refreshFailure != null) {
                showAnimatedSnakDialogue(
                  context,
                  message: state.refreshFailure!.message,
                  type: AnimatedSnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              final bool isLoadingInitial =
                  state.rules.isEmpty &&
                  (state.initialLoadingStatus ==
                          InitialLoadingStatus.initial ||
                      state.initialLoadingStatus ==
                          InitialLoadingStatus.loading);

              if (isLoadingInitial) {
                return const LeaveTypeShimmer();
              } else if (state.initialLoadingStatus ==
                  InitialLoadingStatus.failure) {
                return GeneralErrorWidget(
                  message: state.getRulesFailure!.message,
                  onRetry: eligibilityCubit.getEligibilityRules,
                );
              } else if (state.rules.isEmpty) {
                return const EmptyStateWidget(
                  message: "No eligibility rules found",
                );
              }

              final groups = _groupRules(state.rules);
              return RefreshIndicator(
                onRefresh: eligibilityCubit.refresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 8.h),
                  children: [
                    for (final entry in groups.entries)
                      EligibilityGroupCard(
                        typeName: entry.value.first.leaveType.typeName,
                        category: entry.value.first.leaveType.category,
                        rules: entry.value,
                        deletingId: state.deletingId,
                        onAdd: () => _openCreateSheet(
                          context,
                          preselectedLeaveTypeId: entry.key,
                        ),
                        onDelete: (rule) async {
                          final bool? isConfirmed =
                              await AppDialogs.showDeleteConfirmationDialog(
                                context,
                                message:
                                    "Remove this eligibility rule? Users of "
                                    "this type will no longer see this leave "
                                    "type when applying.",
                                confirmText: "Remove",
                                cancelText: "Cancel",
                              );
                          if (isConfirmed == true) {
                            eligibilityCubit.deleteEligibilityRule(
                              rule.eligibilityId,
                            );
                          }
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Eligibility Rule",
        onPressed: () => _openCreateSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
