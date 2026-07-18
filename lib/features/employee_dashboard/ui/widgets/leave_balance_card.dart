import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

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
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 20.h),
          if (isCircular && progressValue != null)
            _buildCircularProgress(context)
          else
            _buildLargeText(context),
          SizedBox(height: 20.h),
          _buildBottomBadge(context),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(BuildContext context) {
    return SizedBox(
      height: 70.sp,
      width: 70.sp,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 8.w,
            backgroundColor: context.colorScheme.outline,
            color: context.colorScheme.primary,
          ),
          Center(
            child: Text(
              balance.toString(),
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.primary,
                fontSize: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeText(BuildContext context) {
    return Text(
      balance.toString(),
      style: context.textTheme.headlineMedium?.copyWith(
        color: context.colorScheme.primary,
        fontSize: 40.sp,
      ),
    );
  }

  Widget _buildBottomBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text.rich(
          TextSpan(
            text: 'Taken: $taken ',
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
            children: [
              TextSpan(
                text: ' |  Total: $total',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
