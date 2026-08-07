import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class ManagerCoverageShimmer extends StatelessWidget {
  const ManagerCoverageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: colors.outline.withValues(alpha: 0.3),
        highlightColor: colors.surface,
        child: Container(
          height: 110.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
