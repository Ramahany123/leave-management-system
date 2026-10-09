import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/leave_type_options.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/form_label_widget.dart';

class LeaveTypeLimitsSection extends StatelessWidget {
  final TextEditingController lifetimeLimitController;
  final TextEditingController yearsOfServiceController;
  final TextEditingController maxDaysPerRequestController;
  final TextEditingController minDaysDurationController;
  final TextEditingController requiredGapDaysController;
  final String? selectedGenderPolicy;
  final ValueChanged<String?> onGenderPolicyChanged;
  final bool isDisabled;

  const LeaveTypeLimitsSection({
    super.key,
    required this.lifetimeLimitController,
    required this.yearsOfServiceController,
    required this.maxDaysPerRequestController,
    required this.minDaysDurationController,
    required this.requiredGapDaysController,
    required this.selectedGenderPolicy,
    required this.onGenderPolicyChanged,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelWidget(
          label: "Years of Service Required",
          isRequired: true,
        ),
        CustomTextField(
          hintText: "Minimum years of service (e.g. 0)",
          controller: yearsOfServiceController,
          validator: AppValidators.validateRequiredInt,
          isEnabled: !isDisabled,
          textInputType: TextInputType.number,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Lifetime Limit"),
        CustomTextField(
          hintText: "Max times per career (e.g. 1), leave blank for no limit",
          controller: lifetimeLimitController,
          validator: AppValidators.validateOptionalInt,
          isEnabled: !isDisabled,
          textInputType: TextInputType.number,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Max Days Per Request"),
        CustomTextField(
          hintText: "Leave blank for no limit",
          controller: maxDaysPerRequestController,
          validator: AppValidators.validateOptionalInt,
          isEnabled: !isDisabled,
          textInputType: TextInputType.number,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Min Days Duration", isRequired: true),
        CustomTextField(
          hintText: "Minimum days per request (e.g. 1)",
          controller: minDaysDurationController,
          validator: AppValidators.validateRequiredInt,
          isEnabled: !isDisabled,
          textInputType: TextInputType.number,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Required Gap Days", isRequired: true),
        CustomTextField(
          hintText: "Days required between two requests (e.g. 0)",
          controller: requiredGapDaysController,
          validator: AppValidators.validateRequiredInt,
          isEnabled: !isDisabled,
          textInputType: TextInputType.number,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Gender Policy", isRequired: true),
        DropdownButtonFormField<String>(
          hint: const Text("Select gender policy"),
          initialValue: selectedGenderPolicy,
          validator: (value) => value == null ? "This field is required" : null,
          items: LeaveTypeOptions.withCurrent(
            LeaveTypeOptions.genderPolicies,
            selectedGenderPolicy,
          )
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: isDisabled ? null : onGenderPolicyChanged,
        ),
      ],
    );
  }
}
