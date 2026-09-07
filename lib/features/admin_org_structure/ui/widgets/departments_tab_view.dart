import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/departments_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/college_filter_chips_bar.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/department_card.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/departments_list_shimmer.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../../../core/utils/app_dialogs.dart';

class DepartmentsTabView extends StatefulWidget {
  const DepartmentsTabView({super.key});

  @override
  State<DepartmentsTabView> createState() => _DepartmentsTabViewState();
}

class _DepartmentsTabViewState extends State<DepartmentsTabView> {
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
    final deptCubit = context.read<DepartmentsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          CustomSearchField(
            controller: _searchController,
            hintText: "Search by department name / head name",
            onChanged: (query) => deptCubit.searchDepartments(query),
          ),
          SizedBox(height: 10.h),
          BlocSelector<DepartmentsCubit, DepartmentsState, int?>(
            selector: (state) =>
                state is DepartmentsSuccess ? state.collegeId : null,
            builder: (context, selectedCollegeId) {
              return CollegeFilterChipsBar(
                selectedCollegeId: selectedCollegeId,
                onCollegeSelected: (id) {
                  deptCubit.filterbyCollegeId(id);
                },
              );
            },
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: BlocBuilder<DepartmentsCubit, DepartmentsState>(
              builder: (context, state) {
                return switch (state) {
                  DepartmentsInitial() ||
                  DepartmentsLoading() =>
                    const DepartmentsListShimmer(),
                  DepartmentsError(:final failure) => GeneralErrorWidget(
                      message: failure.message,
                      onRetry: deptCubit.getAllDepartments,
                    ),
                  DepartmentsSuccess(:final departments) => RefreshIndicator(
                      onRefresh: deptCubit.getAllDepartments,
                      child: departments.isEmpty
                          ? Center(
                              child: Text(
                                "No Departments found",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final department = departments[index];
                                return DepartmentCard(
                                  department: department,
                                  onEdit: () async {
                                    final bool? isUpdated =
                                        await AppDialogs.showDeparmtentFormSheet(
                                          context,
                                          department: department,
                                        );
                                    if (isUpdated == true &&
                                        context.mounted) {
                                      deptCubit.getAllDepartments();
                                    }
                                  },
                                  onDelete: () async {
                                    final bool? isDeleted =
                                        await AppDialogs.showDeleteConfirmationDialog(
                                          context,
                                          message:
                                              "Do You Want To Delete This Department?",
                                        );
                                    if (isDeleted == true &&
                                        context.mounted) {
                                      deptCubit.deleteDepartment(
                                        department.departmentId,
                                      );
                                    }
                                  },
                                );
                              },
                              separatorBuilder: (_, _) =>
                                  SizedBox(height: 12.h),
                              itemCount: departments.length,
                            ),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
