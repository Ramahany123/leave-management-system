import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/widgets/custom_choice_chip.dart';
import 'package:leave_management_system/features/manager_reports/logic/cubit/manager_report_cubit.dart';

import '../../../../core/language/locale_keys.g.dart';
import '../../../../core/utils/date_extension.dart';

class ReportFilterBar extends StatelessWidget {
  final String? selectedStatus;
  final DateTimeRange? selectedRange;

  Future<void> _pickDateRange(BuildContext context) async {
    final picked = await DatePickerHelper.pickDateRange(
      context,
      initialDateRange: selectedRange,
    );
    if (picked != null && context.mounted) {
      context.read<ManagerReportCubit>().changeDateRangeFilter(picked);
    }
  }

  const ReportFilterBar({super.key, this.selectedStatus, this.selectedRange});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _pickDateRange(context),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(
                color: selectedRange != null
                    ? colorScheme.primary
                    : colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18.sp,
                  color: selectedRange != null
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    selectedRange != null
                        ? '${selectedRange!.start.toApiDate} ➔ ${selectedRange!.end.toApiDate}'
                        : LocaleKeys.manager_reports_filter_by_date.tr(),
                    style: textTheme.labelMedium?.copyWith(
                      color: selectedRange != null
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                      fontWeight: selectedRange != null
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (selectedRange != null) ...[
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      context.read<ManagerReportCubit>().changeDateRangeFilter(
                        null,
                      );
                    },
                    child: Icon(
                      Icons.close_rounded,
                      size: 16.sp,
                      color: context.colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 8.w,
            children: [
              CustomChoiceChip(
                isSelected: selectedStatus == null,
                label: LocaleKeys.manager_reports_all.tr(),
                onTap: () =>
                    context.read<ManagerReportCubit>().changeStatusFilter(null),
              ),
              CustomChoiceChip(
                isSelected: selectedStatus == RequestStatues.pending,
                label: LocaleKeys.manager_reports_pending.tr(),
                onTap: () => context
                    .read<ManagerReportCubit>()
                    .changeStatusFilter(RequestStatues.pending),
              ),
              CustomChoiceChip(
                isSelected: selectedStatus == RequestStatues.approved,
                label: LocaleKeys.manager_reports_approved.tr(),
                onTap: () => context
                    .read<ManagerReportCubit>()
                    .changeStatusFilter(RequestStatues.approved),
              ),
              CustomChoiceChip(
                isSelected: selectedStatus == RequestStatues.rejected,
                label: LocaleKeys.manager_reports_rejected.tr(),
                onTap: () => context
                    .read<ManagerReportCubit>()
                    .changeStatusFilter(RequestStatues.rejected),
              ),
              CustomChoiceChip(
                isSelected: selectedStatus == RequestStatues.cancelled,
                label: LocaleKeys.manager_reports_cancelled.tr(),
                onTap: () => context
                    .read<ManagerReportCubit>()
                    .changeStatusFilter(RequestStatues.cancelled),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
