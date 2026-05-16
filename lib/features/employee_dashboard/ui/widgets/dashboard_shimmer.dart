import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. "My Balances" Title Skeleton
          Container(
            width: 120.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 16.h),

          // 2. Balances List Skeleton (Horizontal)
          SizedBox(
            height: 240.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              itemBuilder: (context, index) => Container(
                width: index == 0 ? 220.w : 160.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // 3. "Recent Requests" Row Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Container(
                width: 60.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // 4. Recent Requests List Skeleton (Vertical)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) => Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
