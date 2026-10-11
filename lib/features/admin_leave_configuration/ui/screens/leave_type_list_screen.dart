import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/core/widgets/empty_state_widget.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/initial_loading_status.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_card.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_shimmer.dart';

import '../../../../core/routes/app_routes.dart';

class LeaveTypeListScreen extends StatefulWidget {
  const LeaveTypeListScreen({super.key});

  @override
  State<LeaveTypeListScreen> createState() => _LeaveTypeListScreenState();
}

class _LeaveTypeListScreenState extends State<LeaveTypeListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaveTypeCubit = context.read<LeaveTypeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Types"),
        actions: [
          IconButton(
            tooltip: "Eligibility Rules",
            onPressed: () => context.push(AppRoutes.adminEligibilityListScreen),
            icon: const Icon(Icons.groups_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              CustomSearchField(
                controller: _searchController,
                hintText: "Search by leave type name...",
                onChanged: (val) {
                  leaveTypeCubit.search(val);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocConsumer<LeaveTypeCubit, LeaveTypeState>(
                  listenWhen: (prev, curr) =>
                      prev.deleteLeaveTypeFailure !=
                          curr.deleteLeaveTypeFailure ||
                      prev.refreshFailure != curr.refreshFailure,
                  listener: (BuildContext context, LeaveTypeState state) {
                    if (state.deleteLeaveTypeFailure != null) {
                      showAnimatedSnakDialogue(
                        context,
                        message: state.deleteLeaveTypeFailure!.message,
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
                        state.leaveTypesList.isEmpty &&
                        (state.initialLoadingStatus ==
                                InitialLoadingStatus.initial ||
                            state.initialLoadingStatus ==
                                InitialLoadingStatus.loading);

                    if (isLoadingInitial) {
                      return const LeaveTypeShimmer();
                    } else if (state.initialLoadingStatus ==
                        InitialLoadingStatus.failure) {
                      return GeneralErrorWidget(
                        message: state.getLeaveTypeFailure!.message,
                        onRetry: leaveTypeCubit.getLeaveTypes,
                      );
                    } else if (state.leaveTypesList.isEmpty) {
                      return EmptyStateWidget(
                        message: state.searchQuery.isEmpty
                            ? "No leave types found"
                            : "No leave types match your search",
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: leaveTypeCubit.refresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.leaveTypesList.length,
                        itemBuilder: (context, index) {
                          final leaveType = state.leaveTypesList[index];
                          return LeaveTypeCard(
                            leaveType: leaveType,
                            isDeleting:
                                state.deletingLeaveId == leaveType.typeId,
                            onDelete: () async {
                              final bool? isDeleted =
                                  await AppDialogs.showDeleteConfirmationDialog(
                                    context,
                                    message:
                                        "Are you sure you want to delete "
                                        "this leave type? Existing leave "
                                        "requests will keep their history.",
                                    confirmText: "Confirm",
                                    cancelText: "Cancel",
                                  );
                              if (isDeleted == true) {
                                leaveTypeCubit.deleteLeaveType(
                                  leaveType.typeId,
                                );
                              }
                            },
                            onTap: () {
                              _openForm(context, leaveTypeCubit, leaveType);
                            },
                            onEdit: () {
                              _openForm(context, leaveTypeCubit, leaveType);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Leave Type",
        onPressed: () {
          _openForm(context, leaveTypeCubit, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context,
    LeaveTypeCubit cubit,
    dynamic leaveType,
  ) async {
    final bool? isSaved = await context.push<bool>(
      AppRoutes.adminLeaveTypeFormScreen,
      extra: leaveType,
    );
    if (isSaved == true && context.mounted) {
      showAnimatedSnakDialogue(
        context,
        message: leaveType == null
            ? "Leave Type Created Successfully"
            : "Leave Type Updated Successfully",
      );
      cubit.refresh();
    }
  }
}
