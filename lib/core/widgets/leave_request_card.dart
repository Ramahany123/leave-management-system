import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

import 'status_badging.dart';

class LeaveRequestCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final IconData statusIcon;
  final void Function()? onTap;

  const LeaveRequestCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.statusIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    date,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              StatusBadging(status: status),
            ],
          ),
        ),
      ),
    );
  }
}
