import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';
import 'package:leave_management_system/core/widgets/status_badging.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';

class ReportRequestCard extends StatelessWidget {
  final ReportLeaveRequest request;
  final VoidCallback? onTap;

  const ReportRequestCard({super.key, required this.request, this.onTap});

  @override
  Widget build(BuildContext context) {
    final leaveTypeLabel =
        request.leaveType?.name ??
        LocaleKeys.admin_reports_deleted_leave_type.tr();
    final departmentLabel =
        request.user.department?.name ??
        LocaleKeys.admin_reports_no_department.tr();
    final dateRange = request.startDate.toReadableDateRange(request.endDate);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameAvatar(name: request.user.name),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.user.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        StatusBadging(status: request.status),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '$leaveTypeLabel · $departmentLabel',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateRange,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
