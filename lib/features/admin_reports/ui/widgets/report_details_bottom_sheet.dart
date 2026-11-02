import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/core/widgets/key_value_row_widget.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/core/widgets/status_badging.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';

/// Read-only ledger row details; override is injected by the caller.
class ReportDetailsBottomSheet extends StatelessWidget {
  final ReportLeaveRequest request;
  final Future<bool?> Function() onOverride;

  const ReportDetailsBottomSheet({
    super.key,
    required this.request,
    required this.onOverride,
  });

  Future<void> _handleOverride(BuildContext context) async {
    final didOverride = await onOverride();
    // Only a committed override closes the sheet.
    if (didOverride == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveTypeLabel =
        request.leaveType?.name ??
        LocaleKeys.admin_reports_deleted_leave_type.tr();
    final email = request.user.email;

    return CustomBottomSheetShell(
      title: LocaleKeys.leave_history_details_title.tr(),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Applicant header ----------
              Row(
                children: [
                  NameAvatar(name: request.user.name),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.user.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (email != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            email,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // ---------- Leave information ----------
              InfoSection(
                title: LocaleKeys.leave_history_leave_information.tr(),
                children: [
                  KeyValueRow(
                    label: LocaleKeys.leave_history_type.tr(),
                    value: leaveTypeLabel,
                  ),
                  KeyValueRow(
                    label: LocaleKeys.leave_history_status.tr(),
                    widget: StatusBadging(status: request.status),
                  ),
                  if (request.duration != null)
                    KeyValueRow(
                      label: LocaleKeys.leave_history_duration.tr(),
                      value: LocaleKeys.leave_history_days_format.tr(
                        namedArgs: {'count': request.duration.toString()},
                      ),
                    ),
                  if (request.reason != null)
                    KeyValueRow(
                      label: LocaleKeys.leave_history_reason.tr(),
                      value: request.reason,
                    ),
                ],
              ),
              SizedBox(height: 24.h),

              // ---------- Timing details ----------
              InfoSection(
                title: LocaleKeys.leave_history_timing_details.tr(),
                children: [
                  KeyValueRow(
                    label: LocaleKeys.leave_history_start_date.tr(),
                    value: request.startDate.toReadableDate,
                  ),
                  KeyValueRow(
                    label: LocaleKeys.leave_history_end_date.tr(),
                    value: request.endDate.toReadableDate,
                  ),
                  if (request.returnedAt != null)
                    KeyValueRow(
                      label: LocaleKeys.leave_history_returned_at.tr(),
                      value: request.returnedAt!.toReadableDate,
                    ),
                  KeyValueRow(
                    label: LocaleKeys.leave_history_applied_on.tr(),
                    value: request.createdAt.toReadableDate,
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // ---------- Additional details ----------
              InfoSection(
                title: LocaleKeys.leave_history_additional_details.tr(),
                children: [
                  KeyValueRow(
                    label: LocaleKeys.leave_history_pre_leave_ack.tr(),
                    value: request.preLeaveAcknowledgement
                        ? LocaleKeys.leave_history_completed.tr()
                        : LocaleKeys.leave_history_pending.tr(),
                  ),
                  KeyValueRow(
                    label: LocaleKeys.admin_reports_department.tr(),
                    value:
                        request.user.department?.name ??
                        LocaleKeys.admin_reports_no_department.tr(),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // ---------- Administrative action ----------
              SizedBox(
                width: double.infinity,
                child: PrimaryButtonWidget(
                  backgroundColor: context.colorScheme.errorContainer,
                  onPressed: () => _handleOverride(context),
                  child: Text(
                    LocaleKeys.admin_reports_override_status.tr(),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
