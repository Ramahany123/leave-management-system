import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/models/user_model.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/date_extension.dart';
import '../../../../core/widgets/key_value_row_widget.dart';

class PersonalInfoBottomSheet extends StatelessWidget {
  final UserModel user;
  const PersonalInfoBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.cardBorderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            //TODO: localize texts
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Personal Information",
                style: AppTextStyles.black20w600TextStyle,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close, color: AppColors.greyColor),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildInfoSection("OFFICIAL DETAILS", [
            KeyValueRow(label: "National ID (SSN)", value: user.ssn),
            KeyValueRow(
              label: "Birth Date",
              value: user.dateOfBirth.toReadableDate,
            ),
            KeyValueRow(label: "Gender", value: user.gender),
            KeyValueRow(label: "phone", value: user.phone),
          ]),
          SizedBox(height: 24.h),

          _buildInfoSection("UNIVERSITY DETAILS", [
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

          SizedBox(height: 32.h), // Bottom padding for safety
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.grey12w500TextStyle.copyWith(letterSpacing: 1.1),
        ),
        SizedBox(height: 12.h),
        ...children,
      ],
    );
  }
}
