import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_text_styles.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? widget;
  const KeyValueRow({super.key, required this.label, this.value, this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.grey14w400TextStyle),
          widget ??
              (value != null
                  ? Text(value!, style: AppTextStyles.black14w600TextStyle)
                  : SizedBox.shrink()),
        ],
      ),
    );
  }
}
