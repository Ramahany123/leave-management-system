import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/college_drop_down.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/department_drop_down.dart';

import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/form_label_widget.dart';

class AdminUserOrganizationSection extends StatelessWidget {
  final String? selectedGender;
  final int? selectedCollegeId;
  final int? selectedDepartmentId;
  final DateTime? selectedHireDate;
  final DateTime? selectedDateOfBirth;
  final String? selectedRole;
  final UserType? selectedUserType;
  final List<String> gender;

  final TextEditingController hireDateController;
  final TextEditingController dateOfBirthController;

  final void Function(String?)? onGenderChanged;
  final void Function(int?)? onCollegeChanged;
  final void Function(int?)? onDepartmentChanged;
  final void Function(String?)? onRoleChanged;
  final void Function(UserType?)? onUserTypeChanged;
  final VoidCallback onHireDateTap;
  final VoidCallback onDateOfBirthTap;

  final bool isDisabled;
  const AdminUserOrganizationSection({
    super.key,
    required this.selectedGender,
    required this.selectedCollegeId,
    required this.selectedDepartmentId,
    required this.selectedHireDate,
    required this.selectedDateOfBirth,
    required this.selectedRole,
    required this.selectedUserType,
    required this.hireDateController,
    required this.dateOfBirthController,
    required this.onGenderChanged,
    required this.onCollegeChanged,
    required this.onDepartmentChanged,
    required this.onRoleChanged,
    required this.onUserTypeChanged,
    required this.isDisabled,
    required this.gender,
    required this.onHireDateTap,
    required this.onDateOfBirthTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormLabelWidget(label: "Gender", isRequired: true),
        DropdownButtonFormField<String>(
          hint: const Text("Select Gender"),
          initialValue: selectedGender,
          validator: AppValidators.validateField,
          items: gender
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: isDisabled ? null : onGenderChanged,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "College", isRequired: true),
        CollegeDropDown(
          isDisabled: isDisabled,
          selectedCollegeId: selectedCollegeId,
          onChanged: onCollegeChanged,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Department", isRequired: true),
        DepartmentDropDown(
          selectedCollegeId: selectedCollegeId,
          selectedDepartmentId: selectedDepartmentId,
          isDisabled: isDisabled,
          onChanged: onDepartmentChanged,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Hire Date", isRequired: true),
        CustomTextField(
          controller: hireDateController,
          onTap: onHireDateTap,
          readOnly: true,
          hintText: "Select Hire Date",
          validator: (_) {
            return AppValidators.validateRequired(selectedHireDate);
          },
          suffixIcon: const Icon(Icons.calendar_month),
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Date Of Birth", isRequired: true),
        CustomTextField(
          controller: dateOfBirthController,
          onTap: onDateOfBirthTap,
          readOnly: true,
          hintText: "Select Date Of Birth",
          validator: (_) {
            return AppValidators.validateRequired(selectedDateOfBirth);
          },
          isEnabled: !isDisabled,
          suffixIcon: const Icon(Icons.calendar_month),
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Role", isRequired: true),
        DropdownButtonFormField<String>(
          validator: AppValidators.validateField,
          initialValue: selectedRole,
          hint: const Text("Select Role"),
          items: UserRoles.allRoles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: isDisabled ? null : onRoleChanged,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "User Type", isRequired: true),
        DropdownButtonFormField<UserType>(
          validator: AppValidators.validateRequired,
          initialValue: selectedUserType,
          hint: const Text("Select User Type"),
          items: UserType.values
              .map(
                (item) =>
                    DropdownMenuItem(value: item, child: Text(item.rawValue)),
              )
              .toList(),
          onChanged: isDisabled ? null : onUserTypeChanged,
        ),
      ],
    );
  }
}
