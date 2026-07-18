import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class RequestDetailsShimmer extends StatelessWidget {
  const RequestDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
      highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShimmerSection(context, 3),
          SizedBox(height: 24.h),
          _buildShimmerSection(context, 4),
          SizedBox(height: 24.h),
          _buildShimmerSection(context, 4),
        ],
      ),
    );
  }

  Widget _buildShimmerSection(BuildContext context, int rowCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 130.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 12.h),
        ...List.generate(
          rowCount,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (60 + (index * 15)).w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: (110 - (index * 20)).w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
