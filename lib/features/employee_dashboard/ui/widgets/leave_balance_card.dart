import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

class LeaveBalanceCard extends StatelessWidget {
  final String title;
  final int balance;
  final int total;
  final int taken;
  final double? progressValue;
  final double width;
  final bool isCircular;

  const LeaveBalanceCard({
    super.key,
    required this.title,
    required this.balance,
    required this.total,
    this.progressValue,
    this.width = 220,
    this.isCircular = false,
    required this.taken,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.cardBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.primary16w600TextStyle),
          SizedBox(height: 20.h),
          if (isCircular && progressValue != null)
            _buildCircularProgress()
          else
            _buildLargeText(),
          SizedBox(height: 20.h),
          _buildBottomBadge(),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    return SizedBox(
      height: 70.sp,
      width: 70.sp,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 8.w,
            backgroundColor: AppColors.cardBorderColor,
            color: AppColors.primaryBlue,
          ),
          Center(
            child: Text(
              balance.toString(),
              style: AppTextStyles.primaryBlue20w600TextStyle.copyWith(
                fontSize: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeText() {
    return Text(
      balance.toString(),
      style: AppTextStyles.primaryBlue20w600TextStyle.copyWith(fontSize: 40.sp),
    );
  }

  Widget _buildBottomBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text.rich(
          TextSpan(
            text: 'Taken: $taken ',
            style: AppTextStyles.primary14w600TextStyle,
            children: [
              TextSpan(
                text: ' |  Total: $total',
                style: AppTextStyles.grey14w400TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
