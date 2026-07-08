import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/request_status_extension.dart';

class StatusBadging extends StatelessWidget {
  const StatusBadging({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: status.getStatusColor.withAlpha(35),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(status.getStatusIcon, color: status.getStatusColor, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            status,
            style: TextStyle(
              color: status.getStatusColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
