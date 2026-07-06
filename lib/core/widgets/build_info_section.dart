import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_text_styles.dart';

Widget buildInfoSection(String title, List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTextStyles.grey12w500TextStyle.copyWith(letterSpacing: 1.1),
      ),
      SizedBox(height: 12.h),
      ...children,
    ],
  );
}
