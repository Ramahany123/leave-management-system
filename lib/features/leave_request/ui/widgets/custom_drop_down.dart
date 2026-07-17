import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';

import '../../../../core/styles/app_text_styles.dart';

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
        color: isEnabled ? AppColors.whiteColor : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isEnabled ? AppColors.cardBorderColor : Colors.grey.shade300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(hint, style: AppTextStyles.grey14w400TextStyle),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: isEnabled ? onChanged : null,
          items: items
              .map<DropdownMenuItem<T>>(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(itemAsString(item)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
