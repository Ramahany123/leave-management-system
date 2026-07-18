import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? widget;
  const KeyValueRow({super.key, required this.label, this.value, this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          widget ??
              (value != null
                  ? Text(
                      value!,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    )
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
