import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RequestDetailsShimmer extends StatelessWidget {
  const RequestDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShimmerSection(3), // Mirror LEAVE INFORMATION
          SizedBox(height: 24.h),
          _buildShimmerSection(4), // Mirror TIMING DETAILS
          SizedBox(height: 24.h),
          _buildShimmerSection(4), // Mirror ADDITIONAL DETAILS
        ],
      ),
    );
  }

  Widget _buildShimmerSection(int rowCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section Title Placeholder
        Container(
          width: 130.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 12.h),
        // Rows Placeholder
        ...List.generate(
          rowCount,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label block (varied widths: 60.w, 75.w, 90.w, etc.)
                Container(
                  width: (60 + (index * 15)).w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                // Value block (varied widths: 110.w, 90.w, 70.w, etc.)
                Container(
                  width: (110 - (index * 20)).w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
