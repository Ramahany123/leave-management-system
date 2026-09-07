import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/colleges_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/college_card.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/org_structure_shimmer.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../../../core/widgets/general_error_widget.dart';

class CollegeTabView extends StatefulWidget {
  const CollegeTabView({super.key});

  @override
  State<CollegeTabView> createState() => _CollegeTabViewState();
}

class _CollegeTabViewState extends State<CollegeTabView> {
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
    final collegesCubit = context.read<CollegesCubit>();
    return BlocBuilder<CollegesCubit, CollegesState>(
      builder: (context, state) {
        return switch (state) {
          CollegesInitial() || CollegesLoading() => const OrgStructureShimmer(),
          CollegesError(:final failure) => GeneralErrorWidget(
            message: failure.message,
            onRetry: () => collegesCubit.getAllColleges(),
          ),
          CollegesSuccess(:final colleges) => RefreshIndicator(
            onRefresh: () => collegesCubit.getAllColleges(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  CustomSearchField(
                    controller: _searchController,
                    hintText: "Search by college name/ dean name",
                    onChanged: (query) => collegesCubit.searchColleges(query),
                  ),
                  SizedBox(height: 16.h),
                  if (colleges.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No colleges found",
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: colleges.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final college = colleges[index];
                          final id = college.collegeId;
                          return CollegeCard(
                            college: college,
                            onTap: () {
                              AppDialogs.showCollegeDetailsSheet(context, id);
                            },
                            onEdit: () async {
                              final bool? isUpdated =
                                  await AppDialogs.showCollegeFormSheet(
                                    context,
                                    college: college,
                                  );
                              if (isUpdated == true && context.mounted) {
                                collegesCubit.getAllColleges();
                              }
                            },
                            onDelete: () async {
                              final bool? isDeleted =
                                  await AppDialogs.showDeleteConfirmationDialog(
                                    context,
                                    message:
                                        "Do You Want To Delete This College?",
                                  );
                              if (isDeleted == true && context.mounted) {
                                collegesCubit.deleteCollege(id);
                              }
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        };
      },
    );
  }
}
