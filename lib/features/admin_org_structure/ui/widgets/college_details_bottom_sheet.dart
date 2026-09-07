import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/core/widgets/key_value_row_widget.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/college_details_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/college_details_shimmer.dart';

class CollegeDetailsBottomSheet extends StatelessWidget {
  final int collegeId;
  const CollegeDetailsBottomSheet({super.key, required this.collegeId});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: CustomBottomSheetShell(
        title: "College Details",
        content: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocBuilder<CollegeDetailsCubit, CollegeDetailsState>(
            builder: (context, state) {
              final cubit = context.read<CollegeDetailsCubit>();
              switch (state) {
                case CollegeDetailsInitial():
                case CollegeDetailsLoading():
                  return const CollegeDetailsShimmer();
                case CollegeDetailsError(:final failure):
                  return GeneralErrorWidget(
                    message: failure.message,
                    onRetry: () => cubit.getCollegeDetails(collegeId),
                  );
                case CollegeDetailsSuccess(:final college):
                  return _buildDetailsContent(context, college);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsContent(BuildContext context, CollegeModel college) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================== 1. COLLEGE INFORMATION ====================
        InfoSection(
          title: "COLLEGE INFORMATION",
          children: [
            KeyValueRow(
              label: "College Name",
              value: college.collegeName,
            ),
            KeyValueRow(
              label: "Total Departments",
              value: "${college.departments.length}",
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // ==================== 2. DEAN INFORMATION ====================
        InfoSection(
          title: "DEAN INFORMATION",
          children: college.dean != null
              ? [
                  KeyValueRow(
                    label: "Dean Name",
                    value: college.dean!.name,
                  ),
                  KeyValueRow(
                    label: "Dean Email",
                    value: college.dean!.email,
                  ),
                ]
              : [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      "No Dean assigned to this college.",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
        ),
        SizedBox(height: 20.h),

        // ==================== 3. DEPARTMENTS LIST ====================
        InfoSection(
          title: "DEPARTMENTS (${college.departments.length})",
          children: college.departments.isEmpty
              ? [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      "No departments registered in this college yet.",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ]
              : [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: college.departments.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final dept = college.departments[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: context.colorScheme.outline.withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.business_outlined,
                              size: 18.sp,
                              color: context.colorScheme.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                dept.departmentName,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
        ),
      ],
    );
  }
}
