import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/widgets/status_badging.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../data/models/manager_reports_model.dart';

class ReportItemCard extends StatelessWidget {
  final ReportRecord record;
  const ReportItemCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    final text = context.textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Header Row (Employee Name + Status Badge)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  record.employeeName,
                  style: text.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              StatusBadging(status: record.status),
            ],
          ),
          SizedBox(height: 10.h),

          // 2. Sub-Info (Department & Leave Type)
          Row(
            children: [
              Icon(
                Icons.business_rounded,
                size: 16.sp,
                color: color.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              Text(
                record.department,
                style: text.bodySmall?.copyWith(color: color.onSurfaceVariant),
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.beach_access_rounded,
                size: 16.sp,
                color: color.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  record.leaveType,
                  style: text.bodySmall?.copyWith(
                    color: color.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // 3. Timing & Duration Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 16.sp,
                    color: color.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${record.startDate?.toApiDate ?? ''}  ➔  ${record.endDate?.toApiDate ?? ''}',
                    style: text.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: color.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  LocaleKeys.leave_history_days_format.tr(
                    namedArgs: {'count': record.duration.toString()},
                  ),
                  style: text.labelSmall?.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // 4. Expandable Approver Comments
          if (record.comments.isNotEmpty) ...[
            const Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.only(top: 8.h),
              shape: const Border(), // 👈 Removes default top/bottom borders
              collapsedShape: const Border(),
              title: Text(
                '${LocaleKeys.manager_reports_comments_history.tr()} (${record.comments.length})',
                style: text.labelMedium?.copyWith(
                  color: color.onSurfaceVariant,
                ),
              ),
              children: record.comments.map((comment) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: color.outline.withAlpha(20),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${comment.approver} (${comment.role})',
                            style: text.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StatusBadging(status: comment.status),
                        ],
                      ),
                      if (comment.comment.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(comment.comment, style: text.bodySmall),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
