import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class LeaveRequestShimmer extends StatelessWidget {
  const LeaveRequestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
      highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Skeleton(width: 100, height: 16),
            SizedBox(height: 8.h),
            const _Skeleton(width: double.infinity, height: 48),
            SizedBox(height: 20.h),

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

            const _Skeleton(width: 80, height: 16),
            SizedBox(height: 8.h),
            const _Skeleton(width: double.infinity, height: 56),
            SizedBox(height: 20.h),

            const _Skeleton(width: double.infinity, height: 120),
            SizedBox(height: 40.h),

            const Center(child: _Skeleton(width: 331, height: 56)),
          ],
        ),
      ),
    );
  }
}

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
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
