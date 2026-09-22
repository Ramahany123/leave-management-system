import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/form_label_widget.dart';

class AdminUserBasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController ssnController;
  final TextEditingController jobTitleController;
  final TextEditingController workplaceController;
  final bool isDisabled;
  const AdminUserBasicInfoSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.ssnController,
    required this.jobTitleController,
    required this.workplaceController,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormLabelWidget(label: "Full Name", isRequired: true),
        CustomTextField(
          hintText: "Enter full name",
          controller: nameController,
          validator: AppValidators.validateField,
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "University Email", isRequired: true),
        CustomTextField(
          hintText: "Enter university email",
          controller: emailController,
          validator: AppValidators.validateEmail,
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "National ID (SSN)", isRequired: true),
        CustomTextField(
          hintText: "Enter 14-digit National ID",
          controller: ssnController,
          validator: AppValidators.validateField,
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Job Title"),
        CustomTextField(
          hintText: "Enter job title",
          controller: jobTitleController,
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Workplace"),
        CustomTextField(
          hintText: "Enter workplace / office",
          controller: workplaceController,
          isEnabled: !isDisabled,
        ),
      ],
    );
  }
}
