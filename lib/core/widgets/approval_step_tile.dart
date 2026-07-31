import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_context_extension.dart';
import '../utils/request_status_extension.dart';

class ApprovalStepTile extends StatelessWidget {
  final String status;
  final String displayName;
  final String roleAtApproval;
  final String? comments;
  final int? sessionNumber;
  final String? sessionDate;
  final String? signatureUrl;

  final bool isLast;

  const ApprovalStepTile({
    super.key,
    required this.isLast,
    required this.status,
    required this.displayName,
    required this.roleAtApproval,
    this.comments,
    this.sessionNumber,
    this.sessionDate,
    this.signatureUrl,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = status.getStatusColor;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: statusColor, width: 2.w),
                ),
                child: Icon(
                  status.getStatusIcon,
                  color: statusColor,
                  size: 14.sp,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: context.colorScheme.outline,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(displayName, style: context.textTheme.titleSmall),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    roleAtApproval,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if ((sessionNumber != null) ||
                      (sessionDate != null && sessionDate!.isNotEmpty)) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.gavel_outlined,
                          size: 14.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${sessionNumber != null ? "Session $sessionNumber" : ""}${sessionNumber != null && sessionDate != null ? " • " : ""}${sessionDate ?? ""}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (comments != null && comments!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Text(
                        comments!,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
