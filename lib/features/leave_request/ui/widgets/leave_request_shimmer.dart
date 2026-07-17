import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';

class LeaveRequestShimmer extends StatelessWidget {
  const LeaveRequestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Leave Type Selector Skeleton
            const _Skeleton(width: 100, height: 16),
            SizedBox(height: 8.h),
            const _Skeleton(width: double.infinity, height: 48),
            SizedBox(height: 20.h),

            // 2. Dates Selection Row Skeleton
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Skeleton(width: 80, height: 16),
                      SizedBox(height: 8.h),
                      const _Skeleton(width: double.infinity, height: 50),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Skeleton(width: 80, height: 16),
                      SizedBox(height: 8.h),
                      const _Skeleton(width: double.infinity, height: 50),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // 3. Reason Field Skeleton
            const _Skeleton(width: 80, height: 16),
            SizedBox(height: 8.h),
            const _Skeleton(width: double.infinity, height: 56),
            SizedBox(height: 20.h),

            // 4. Undertaking Section Skeleton
            const _Skeleton(width: double.infinity, height: 120),
            SizedBox(height: 40.h),

            // 5. Submit Button Skeleton
            Center(child: const _Skeleton(width: 331, height: 56)),
          ],
        ),
      ),
    );
  }
}

// Atomic local Skeleton shape
class _Skeleton extends StatelessWidget {
  final double width;
  final double height;

  const _Skeleton({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
