import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String workPlace;
  const ProfileCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.workPlace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border(
          top: BorderSide(color: context.colorScheme.primary, width: 6.h),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          NameAvatar(name: name),
          SizedBox(height: 16.h),
          Text(
            name,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            jobTitle,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            workPlace,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
