import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_text_styles.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  const KeyValueRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.grey14w400TextStyle),
          Text(value, style: AppTextStyles.black14w600TextStyle),
        ],
      ),
    );
  }
}
