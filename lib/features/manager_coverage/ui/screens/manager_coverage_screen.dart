import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/manager_coverage/logic/cubit/manager_coverage_cubit.dart';
import 'package:leave_management_system/features/manager_coverage/ui/widgets/coverage_date_strip.dart';
import 'package:leave_management_system/features/manager_coverage/ui/widgets/coverage_empty_state.dart';
import 'package:leave_management_system/features/manager_coverage/ui/widgets/manager_coverage_shimmer.dart';
import 'package:leave_management_system/features/manager_coverage/ui/widgets/team_on_leave_list.dart';

import '../../../../core/theme/theme_context_extension.dart';

class ManagerCoverageScreen extends StatefulWidget {
  const ManagerCoverageScreen({super.key});

  @override
  State<ManagerCoverageScreen> createState() => _ManagerCoverageScreenState();
}

class _ManagerCoverageScreenState extends State<ManagerCoverageScreen> {
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
    final coverageCubit = context.read<ManagerCoverageCubit>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchField(
                controller: _searchController,
                hintText: LocaleKeys.manager_coverage_search_hint.tr(),
                onChanged: (query) {
                  coverageCubit.searchTeamMembers(query);
                },
              ),
              SizedBox(height: 20.h),

              BlocBuilder<ManagerCoverageCubit, ManagerCoverageState>(
                builder: (context, state) {
                  final DateTime currentDate = switch (state) {
                    ManagerCoverageSuccess(:final selectedDate) => selectedDate,
                    _ => coverageCubit.selectedDate,
                  };
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CoverageDateStrip(selectedDate: currentDate),
                      SizedBox(height: 20.h),
                      switch (state) {
                        ManagerCoverageLoading() => ManagerCoverageShimmer(),
                        ManagerCoverageError(:final failure) =>
                          GeneralErrorWidget(
                            message: failure.message,
                            onRetry: () {
                              coverageCubit.getTeamOnLeave();
                            },
                          ),
                        ManagerCoverageSuccess(
                          :final filteredEmployees,
                          :final teamOnLeave,
                        ) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CoverageEmployeeCount(count: teamOnLeave.count),
                              SizedBox(height: 20.h),
                              if (filteredEmployees.isEmpty)
                                CoverageEmptyState(
                                  isSearching: _searchController.text
                                      .trim()
                                      .isNotEmpty,
                                )
                              else
                                TeamOnLeaveList(
                                  membersOnLeave: filteredEmployees,
                                ),
                            ],
                          ),
                      },
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoverageEmployeeCount extends StatelessWidget {
  const CoverageEmployeeCount({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          LocaleKeys.manager_coverage_active_leaves_count.tr(
            namedArgs: {'count': count.toString()},
          ),
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
