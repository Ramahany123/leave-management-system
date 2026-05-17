import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';

import '../../../../core/utils/service_locator.dart';

class EmployeeHeader extends StatelessWidget {
  const EmployeeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = sl<AuthRepo>().userName;
    return Row(
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: AppColors.primaryBlue,
          child: Text(
            _getNameInitials(name),
            style: AppTextStyles.white16w600TextStyle.copyWith(fontSize: 20.sp),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.dashboard_good_morning.tr(),
                style: AppTextStyles.grey16w400TextStyle,
              ),
              SizedBox(height: 4.h),
              Text(name, style: AppTextStyles.primaryBlue20w600TextStyle),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.cardBorderColor),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.primaryBlue,
            ),
            onPressed: () {},
          ),
        ),
      ],
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
