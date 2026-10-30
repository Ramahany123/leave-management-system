import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class ReportListShimmer extends StatelessWidget {
  const ReportListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 24.h),
      itemCount: 6,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => const _ReportCardSkeleton(),
    );
  }
}

class _ReportCardSkeleton extends StatelessWidget {
  const _ReportCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
        highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: context.colorScheme.outline,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Varied widths — never uniform blocks.
                      Expanded(
                        child: Container(
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: context.colorScheme.outline,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 64.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: context.colorScheme.outline,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 160.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 110.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
