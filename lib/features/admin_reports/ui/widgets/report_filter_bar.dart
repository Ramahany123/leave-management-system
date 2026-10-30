import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/custom_choice_chip.dart';

class ReportFilterBar extends StatelessWidget {
  final String? selectedStatus;
  final bool hasActiveFilters;
  final ValueChanged<String?> onStatusSelected;
  final VoidCallback onOpenFilters;

  const ReportFilterBar({
    super.key,
    required this.selectedStatus,
    required this.hasActiveFilters,
    required this.onStatusSelected,
    required this.onOpenFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8.w,
              children: [
                _statusChip(null, LocaleKeys.admin_reports_all.tr()),
                _statusChip(
                  RequestStatues.pending,
                  LocaleKeys.admin_reports_pending.tr(),
                ),
                _statusChip(
                  RequestStatues.approved,
                  LocaleKeys.admin_reports_approved.tr(),
                ),
                _statusChip(
                  RequestStatues.rejected,
                  LocaleKeys.admin_reports_rejected.tr(),
                ),
                _statusChip(
                  RequestStatues.cancelled,
                  LocaleKeys.admin_reports_cancelled.tr(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        _FilterButton(isActive: hasActiveFilters, onTap: onOpenFilters),
      ],
    );
  }

  Widget _statusChip(String? status, String label) {
    return CustomChoiceChip(
      isSelected: selectedStatus == status,
      label: label,
      onTap: () => onStatusSelected(status),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _FilterButton({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: isActive
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isActive ? colorScheme.primary : colorScheme.outline,
            ),
          ),
          child: Badge(
            isLabelVisible: isActive,
            child: Icon(
              Icons.tune_rounded,
              size: 22.sp,
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
