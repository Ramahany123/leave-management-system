import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String workPlace;
  const ProfileCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.workPlace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border(
          top: BorderSide(color: AppColors.primaryBlue, width: 6.h),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          NameAvatar(name: name),
          SizedBox(height: 16.h),
          Text(name, style: AppTextStyles.black24w600TextStyle),
          SizedBox(height: 4.h),
          Text(jobTitle, style: AppTextStyles.primary14w600TextStyle),
          SizedBox(height: 4.h),
          Text(workPlace, style: AppTextStyles.grey14w400TextStyle),
        ],
      ),
    );
  }
}
