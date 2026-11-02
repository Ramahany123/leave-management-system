import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/form_label_widget.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_query.dart';

class ReportFilterSheet extends StatefulWidget {
  final ReportQuery initialQuery;
  final Map<int, String> departments;
  final Map<int, String> leaveTypes;

  const ReportFilterSheet({
    super.key,
    required this.initialQuery,
    this.departments = const {},
    this.leaveTypes = const {},
  });

  @override
  State<ReportFilterSheet> createState() => _ReportFilterSheetState();
}

class _ReportFilterSheetState extends State<ReportFilterSheet> {
  late int? _departmentId;
  late int? _typeId;
  late DateTimeRange? _range;

  @override
  void initState() {
    super.initState();
    _departmentId = _existingId(
      widget.initialQuery.departmentId,
      widget.departments,
    );
    _typeId = _existingId(widget.initialQuery.typeId, widget.leaveTypes);
    final start = widget.initialQuery.startDate;
    final end = widget.initialQuery.endDate;
    _range = (start != null && end != null)
        ? DateTimeRange(start: start, end: end)
        : null;
  }

  /// Treats a stored id missing from the options as "no filter" (dropdown assert).
  int? _existingId(int? id, Map<int, String> options) =>
      id != null && options.containsKey(id) ? id : null;

  Future<void> _pickDateRange() async {
    final picked = await DatePickerHelper.pickDateRange(
      context,
      initialDateRange: _range,
    );
    if (picked != null && mounted) {
      setState(() => _range = picked);
    }
  }

  void _apply() {
    Navigator.of(context).pop(
      widget.initialQuery.copyWith(
        departmentId: _departmentId,
        typeId: _typeId,
        startDate: _range?.start,
        endDate: _range?.end,
      ),
    );
  }

  void _reset() {
    Navigator.of(context).pop(
      widget.initialQuery.copyWith(
        departmentId: null,
        typeId: null,
        startDate: null,
        endDate: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetShell(
      title: LocaleKeys.admin_reports_filters.tr(),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- Department ----------
            FormLabelWidget(label: LocaleKeys.admin_reports_department.tr()),
            DropdownButtonFormField<int>(
              initialValue: _departmentId,
              items: [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text(LocaleKeys.admin_reports_all_departments.tr()),
                ),
                for (final entry in widget.departments.entries)
                  DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
              ],
              onChanged: (value) => setState(() => _departmentId = value),
            ),
            SizedBox(height: 16.h),

            // ---------- Leave type ----------
            FormLabelWidget(label: LocaleKeys.admin_reports_leave_type.tr()),
            DropdownButtonFormField<int>(
              initialValue: _typeId,
              items: [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text(LocaleKeys.admin_reports_all_leave_types.tr()),
                ),
                for (final entry in widget.leaveTypes.entries)
                  DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
              ],
              onChanged: (value) => setState(() => _typeId = value),
            ),
            SizedBox(height: 16.h),

            // ---------- Date range ----------
            FormLabelWidget(label: LocaleKeys.admin_reports_date_range.tr()),
            _DateRangeField(
              range: _range,
              onTap: _pickDateRange,
              onClear: () => setState(() => _range = null),
            ),
            SizedBox(height: 24.h),

            // ---------- Actions ----------
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    child: Text(LocaleKeys.admin_reports_reset_filters.tr()),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButtonWidget(
                    onPressed: _apply,
                    child: Text(LocaleKeys.admin_reports_apply_filters.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateRangeField extends StatelessWidget {
  final DateTimeRange? range;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _DateRangeField({
    required this.range,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final hasRange = range != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: hasRange ? colorScheme.primary : colorScheme.outline,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 18.sp,
                color: hasRange
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  hasRange
                      ? '${range!.start.toReadableDate} - ${range!.end.toReadableDate}'
                      : LocaleKeys.admin_reports_any_date.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: hasRange
                        ? colorScheme.onSurface
                        : colorScheme.onSurfaceVariant,
                    fontWeight: hasRange ? FontWeight.w600 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasRange)
                GestureDetector(
                  onTap: onClear,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(4.r),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: colorScheme.error,
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
