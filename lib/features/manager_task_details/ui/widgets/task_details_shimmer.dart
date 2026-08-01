import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme_context_extension.dart';

class TaskDetailsShimmer extends StatelessWidget {
  const TaskDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.2),
      highlightColor: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Requester Info Skeleton lines
          _buildSkeletonLine(width: 140.w, height: 16.h),
          SizedBox(height: 12.h),
          _buildSkeletonLine(width: 220.w, height: 14.h),
          SizedBox(height: 8.h),
          _buildSkeletonLine(width: 180.w, height: 14.h),

          SizedBox(height: 24.h),

          // 2. Leave Info Section Skeleton Card
          _buildSkeletonCard(height: 100.h),

          SizedBox(height: 24.h),

          // 3. Balance Card Skeleton
          _buildSkeletonCard(height: 80.h),
        ],
      ),
    );
  }

  Widget _buildSkeletonLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors
            .white, // Colors.white inside Shimmer gets tinted by baseColor
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }

  Widget _buildSkeletonCard({required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
