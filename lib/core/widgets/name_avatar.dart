import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class NameAvatar extends StatelessWidget {
  final String name;
  const NameAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28.r,
      backgroundColor: AppColors.primaryBlue,
      child: Text(
        _getNameInitials(name),
        style: AppTextStyles.white16w600TextStyle.copyWith(fontSize: 20.sp),
      ),
    );
  }
}

String _getNameInitials(String name) {
  final String trimmedName = name.trim();
  if (trimmedName.isEmpty) return "UN";

  final List<String> parts = trimmedName.split(" ");
  if (parts.length >= 2) {
    return (parts[0][0] + parts[1][0]).toUpperCase();
  } else {
    final String singleName = parts[0];
    return singleName.length >= 2
        ? singleName.substring(0, 2).toUpperCase()
        : singleName.toUpperCase();
  }
}
