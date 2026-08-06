import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/manager_dashboard/logic/cubit/manager_pending_approvals_cubit.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/widgets/pending_approval_list.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/widgets/pending_approvals_list_shimmer.dart';

import '../../../../core/language/locale_keys.g.dart';

class ManagerPendingApprovalsScreen extends StatefulWidget {
  const ManagerPendingApprovalsScreen({super.key});

  @override
  State<ManagerPendingApprovalsScreen> createState() =>
      _ManagerPendingApprovalsScreenState();
}

class _ManagerPendingApprovalsScreenState
    extends State<ManagerPendingApprovalsScreen> {
  late final TextEditingController _searchController;
  late final _pendingApprovalsCubit = context
      .read<ManagerPendingApprovalsCubit>();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.manager_dashboard_pending_approvals.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
        child: Column(
          children: [
            CustomSearchField(
              controller: _searchController,
              hintText: "search name/leave type",
              onChanged: (val) {
                _pendingApprovalsCubit.searchPendingApprovals(val);
              },
            ),
            SizedBox(height: 12.h),
            Expanded(
              child:
                  BlocBuilder<
                    ManagerPendingApprovalsCubit,
                    ManagerPendingApprovalsState
                  >(
                    builder: (context, state) {
                      return switch (state) {
                        ManagerPendingApprovalsLoading() =>
                          PendingApprovalsListShimmer(),
                        ManagerPendingApprovalsError(:final failure) =>
                          GeneralErrorWidget(
                            message: failure.message,
                            onRetry: () {
                              _pendingApprovalsCubit.fetchPendingApprovals();
                            },
                          ),
                        ManagerPendingApprovalsSuccess(
                          :final pendingApprovals,
                        ) =>
                          RefreshIndicator(
                            onRefresh: () {
                              return _pendingApprovalsCubit
                                  .fetchPendingApprovals();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: PendingApprovalList(
                                pendingApprovals: pendingApprovals,
                                onTaskTapped: (pendingTask) async {
                                  await AppDialogs.showTaskDetailsSheet(
                                    context,
                                    pendingTask.stepId,
                                  );
                                  if (context.mounted) {
                                    await _pendingApprovalsCubit
                                        .fetchPendingApprovals();
                                  }
                                },
                              ),
                            ),
                          ),
                      };
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
