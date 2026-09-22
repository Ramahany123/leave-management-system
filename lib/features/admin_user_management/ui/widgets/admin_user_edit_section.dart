import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/core/widgets/form_label_widget.dart';

class AdminUserEditSection extends StatelessWidget {
  final TextEditingController phoneController;
  final bool isActive;
  final ValueChanged<bool>? onActiveChanged;
  final bool isDisabled;

  const AdminUserEditSection({
    super.key,
    required this.phoneController,
    required this.isActive,
    required this.onActiveChanged,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelWidget(label: "Phone Number"),
        CustomTextField(
          controller: phoneController,
          hintText: "Enter phone number",
          isEnabled: !isDisabled,
          textInputType: TextInputType.phone,
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: context.colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: SwitchListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
            title: Text("Active Account", style: context.textTheme.titleSmall),
            subtitle: Text(
              isActive
                  ? "User can log in and access the system"
                  : "Account suspended; user cannot log in",
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            value: isActive,
            onChanged: isDisabled ? null : onActiveChanged,
            activeThumbColor: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
