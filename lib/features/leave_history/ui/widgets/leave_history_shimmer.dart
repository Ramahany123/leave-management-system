import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class LeaveHistoryShimmer extends StatelessWidget {
  const LeaveHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
      highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemBuilder: (context, index) => Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) => Container(
                  height: 90.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
