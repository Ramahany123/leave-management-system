import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:shimmer/shimmer.dart';

class DepartmentsListShimmer extends StatelessWidget {
  const DepartmentsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline.withValues(alpha: 0.4),
      highlightColor: context.colorScheme.outline.withValues(alpha: 0.1),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, __) => Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
