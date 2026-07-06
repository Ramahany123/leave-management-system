import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/models/user_model.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import '../../../../core/utils/date_extension.dart';
import '../../../../core/widgets/build_info_section.dart';
import '../../../../core/widgets/key_value_row_widget.dart';

class PersonalInfoBottomSheet extends StatelessWidget {
  final UserModel user;
  const PersonalInfoBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    //TODO: localize texts
    return CustomBottomSheetShell(
      title: "Personal Information",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInfoSection("OFFICIAL DETAILS", [
            KeyValueRow(label: "National ID (SSN)", value: user.ssn),
            KeyValueRow(
              label: "Birth Date",
              value: user.dateOfBirth.toReadableDate,
            ),
            KeyValueRow(label: "Gender", value: user.gender),
            KeyValueRow(label: "phone", value: user.phone),
          ]),
          SizedBox(height: 24.h),

          buildInfoSection("UNIVERSITY DETAILS", [
            KeyValueRow(
              label: "Hire Date",
              value: user.hireDate.toReadableDate,
            ),
            KeyValueRow(
              label: "Years of Service",
              value: "${user.yearsOfService} Years",
            ),
            KeyValueRow(label: "Role", value: user.role),
            KeyValueRow(label: "Category", value: user.userType),
            KeyValueRow(label: "Work Place", value: user.workplace),
            KeyValueRow(label: "Job Title", value: user.jobTitle),
          ]),
        ],
      ),
    );
  }
}
