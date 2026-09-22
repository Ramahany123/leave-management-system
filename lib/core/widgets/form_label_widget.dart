import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class FormLabelWidget extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormLabelWidget({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 6.h, start: 4.w),
        child: RichText(
          text: TextSpan(
            text: label,
            style: context.textTheme.titleSmall,
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
