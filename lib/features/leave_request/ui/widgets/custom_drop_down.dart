import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String hint;
  final bool isEnabled;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final void Function(T?) onChanged;

  const CustomDropDown({
    super.key,
    required this.hint,
    this.isEnabled = true,
    required this.value,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isEnabled ? context.colorScheme.surface : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isEnabled ? context.colorScheme.outline : Colors.grey.shade300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(
            hint,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.colorScheme.onSurfaceVariant,
          ),
          onChanged: isEnabled ? onChanged : null,
          items: items
              .map<DropdownMenuItem<T>>(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    itemAsString(item),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
