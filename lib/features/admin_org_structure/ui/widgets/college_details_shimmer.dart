import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class CollegeDetailsShimmer extends StatelessWidget {
  const CollegeDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
      highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. College Title Skeleton
          Row(
            children: [
              Container(
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 180.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // 2. Dean Info Card Skeleton
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: context.colorScheme.surface,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 12.h,
                  color: context.colorScheme.surface,
                ),
                SizedBox(height: 12.h),
                Container(
                  width: 160.w,
                  height: 14.h,
                  color: context.colorScheme.surface,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 200.w,
                  height: 12.h,
                  color: context.colorScheme.surface,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // 3. Departments Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.w,
                height: 12.h,
                color: context.colorScheme.surface,
              ),
              Container(
                width: 50.w,
                height: 12.h,
                color: context.colorScheme.surface,
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // 4. Department Items Skeleton List
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Container(
                width: double.infinity,
                height: 44.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
