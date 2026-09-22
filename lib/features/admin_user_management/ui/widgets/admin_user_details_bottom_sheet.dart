import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/core/widgets/key_value_row_widget.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';

class AdminUserDetailsBottomSheet extends StatelessWidget {
  final AdminUserModel user;

  const AdminUserDetailsBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isActive = user.isActive;
    final Color statusColor =
        isActive ? AppColors.successGreen : context.colorScheme.error;

    return CustomBottomSheetShell(
      title: "Staff Details",
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================== 1. PERSONAL INFORMATION ====================
              InfoSection(
                title: "PERSONAL INFORMATION",
                children: [
                  KeyValueRow(label: "Full Name", value: user.name),
                  KeyValueRow(label: "National ID (SSN)", value: user.ssn),
                  KeyValueRow(
                    label: "Date of Birth",
                    value: user.dateOfBirth.toReadableDate,
                  ),
                  if (user.gender != null)
                    KeyValueRow(label: "Gender", value: user.gender),
                  KeyValueRow(label: "Email", value: user.email),
                  KeyValueRow(
                    label: "Phone",
                    value: user.phone ?? "Not provided",
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // ==================== 2. INSTITUTIONAL DETAILS ====================
              InfoSection(
                title: "INSTITUTIONAL DETAILS",
                children: [
                  KeyValueRow(label: "Role", value: user.role),
                  KeyValueRow(
                    label: "Employment Category",
                    value: user.userType,
                  ),
                  KeyValueRow(
                    label: "Job Title",
                    value: user.jobTitle ?? "Not assigned",
                  ),
                  KeyValueRow(
                    label: "College",
                    value: user.college ?? "Not assigned",
                  ),
                  KeyValueRow(
                    label: "Department",
                    value: user.department ?? "Not assigned",
                  ),
                  KeyValueRow(
                    label: "Workplace",
                    value: user.workplace ?? "Not specified",
                  ),
                  KeyValueRow(
                    label: "Hire Date",
                    value: user.hireDate.toReadableDate,
                  ),
                  KeyValueRow(
                    label: "Tenure / Service",
                    value: "${user.yearsOfService} Years",
                  ),
                  KeyValueRow(
                    label: "Account Status",
                    widget: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        isActive ? "Active" : "Inactive",
                        textAlign: TextAlign.end,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
