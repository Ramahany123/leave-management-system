import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
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
    return CustomBottomSheetShell(
      title: LocaleKeys.profile_personal_information_title.tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInfoSection(
            context,
            LocaleKeys.profile_official_details.tr(),
            [
              KeyValueRow(
                label: LocaleKeys.profile_national_id.tr(),
                value: user.ssn,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_birth_date.tr(),
                value: user.dateOfBirth.toReadableDate,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_gender.tr(),
                value: user.gender,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_phone.tr(),
                value: user.phone,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          buildInfoSection(
            context,
            LocaleKeys.profile_university_details.tr(),
            [
              KeyValueRow(
                label: LocaleKeys.profile_hire_date.tr(),
                value: user.hireDate.toReadableDate,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_years_of_service.tr(),
                value: "${user.yearsOfService} Years",
              ),
              KeyValueRow(
                label: LocaleKeys.profile_role.tr(),
                value: user.role,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_category.tr(),
                value: user.userType,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_workplace.tr(),
                value: user.workplace,
              ),
              KeyValueRow(
                label: LocaleKeys.profile_job_title.tr(),
                value: user.jobTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
