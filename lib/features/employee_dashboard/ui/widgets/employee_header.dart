import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

class EmployeeHeader extends StatelessWidget {
  const EmployeeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.grey,
          backgroundImage: const NetworkImage(
            'https://i.pravatar.cc/150?img=11',
          ), // Placeholder
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
              Text(
                'Dr. Ahmed',
                style: AppTextStyles.primaryBlue20w600TextStyle,
              ),
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
