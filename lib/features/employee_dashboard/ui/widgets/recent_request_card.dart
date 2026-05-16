import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

class RecentRequestCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final IconData statusIcon;

  const RecentRequestCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.cardBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.black16w600TextStyle),
              SizedBox(height: 6.h),
              Text(
                date,
                style: AppTextStyles.grey16w400TextStyle.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
