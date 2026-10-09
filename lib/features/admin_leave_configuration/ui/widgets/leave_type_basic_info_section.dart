import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/leave_type_options.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/form_label_widget.dart';

class LeaveTypeBasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;
  final bool isDisabled;

  const LeaveTypeBasicInfoSection({
    super.key,
    required this.nameController,
    required this.categoryController,
    required this.descriptionController,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelWidget(label: "Type Name", isRequired: true),
        CustomTextField(
          hintText: "e.g. Annual Leave",
          controller: nameController,
          validator: AppValidators.validateField,
          isEnabled: !isDisabled,
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Category"),
        CustomTextField(
          hintText: "e.g. Annual (optional)",
          controller: categoryController,
          isEnabled: !isDisabled,
          // backend column is varchar(100)
          textInputFormatter: [LengthLimitingTextInputFormatter(100)],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: [
            for (final suggestion in LeaveTypeOptions.categorySuggestions)
              ActionChip(
                label: Text(suggestion),
                onPressed: isDisabled
                    ? null
                    : () => categoryController.text = suggestion,
              ),
          ],
        ),
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Description"),
        CustomTextField(
          hintText: "Enter a short description",
          controller: descriptionController,
          isEnabled: !isDisabled,
        ),
      ],
    );
  }
}
