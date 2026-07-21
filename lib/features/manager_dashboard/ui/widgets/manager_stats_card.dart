import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class ManagerStatsCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final int statsNumber;
  final IconData icon;
  final double width;
  const ManagerStatsCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.statsNumber,
    required this.icon,
    this.width = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 16.w,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 35.sp,
                height: 35.sp,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "$statsNumber",
            style: context.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            subTitle,
            style: context.textTheme.bodySmall!.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
