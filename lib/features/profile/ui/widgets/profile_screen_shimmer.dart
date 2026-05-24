import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/styles/app_colors.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCardShimmer(),
        SizedBox(height: 32.h),

        // 2. Account & Security Section
        _buildSectionHeaderShimmer(),
        SizedBox(height: 16.h),
        _buildSettingsGroupShimmer(itemCount: 3),
        SizedBox(height: 32.h),
        // 3. Preferences Section
        _buildSectionHeaderShimmer(),
        SizedBox(height: 16.h),
        _buildSettingsGroupShimmer(itemCount: 2),

        SizedBox(height: 32.h),

        // 4. Session Section
        _buildSectionHeaderShimmer(),
        SizedBox(height: 16.h),
        _buildSettingsGroupShimmer(itemCount: 1),
      ],
    );
  }

  Container _buildCardShimmer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            const Skeleton(width: 80, height: 80, isCircle: true),
            SizedBox(height: 16.h),
            const Skeleton(width: 150, height: 20),
            SizedBox(height: 8.h),
            const Skeleton(width: 100, height: 14),
            SizedBox(height: 8.h),
            const Skeleton(width: 180, height: 14),
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionHeaderShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Skeleton(width: 120.w, height: 12.h),
  );
}

Widget _buildSettingsGroupShimmer({required int itemCount}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                const Skeleton(width: 32, height: 32, isCircle: true),
                SizedBox(width: 16.w),
                const Skeleton(width: 120, height: 16),
                const Spacer(),
                const Skeleton(width: 20, height: 20),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class Skeleton extends StatelessWidget {
  final double width, height;
  final bool isCircle;
  const Skeleton({
    super.key,
    required this.width,
    required this.height,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(4.r),
      ),
    );
  }
}
