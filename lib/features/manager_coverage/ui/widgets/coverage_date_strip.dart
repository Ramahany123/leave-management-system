import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/features/manager_coverage/logic/cubit/manager_coverage_cubit.dart';

import '../../../../core/language/locale_keys.g.dart';

class CoverageDateStrip extends StatelessWidget {
  final DateTime selectedDate;
  const CoverageDateStrip({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final bool isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedDate.toReadableDate,
            style: context.textTheme.headlineMedium,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildChoiceChip(
                context,
                isSelected: isToday,
                icon: Icons.access_time_outlined,
                label: LocaleKeys.manager_coverage_today.tr(),
                onTap: () {
                  if (!isToday) {
                    context.read<ManagerCoverageCubit>().getTeamOnLeave(
                      targetDate: DateTime.now(),
                    );
                  }
                },
              ),
              SizedBox(width: 8.w),
              _buildChoiceChip(
                context,
                isSelected: !isToday,
                icon: Icons.calendar_month,
                label: !isToday
                    ? selectedDate.toShortDate
                    : LocaleKeys.manager_coverage_pick_date.tr(),
                onTap: () async {
                  final pickedDate = await DatePickerHelper.pickDate(
                    context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null && context.mounted) {
                    context.read<ManagerCoverageCubit>().getTeamOnLeave(
                      targetDate: pickedDate,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(
    BuildContext context, {
    required bool isSelected,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final color = context.colorScheme;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? color.onPrimary : color.primary),
      ),
      selected: isSelected,
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected
            ? context.colorScheme.onPrimary
            : context.colorScheme.primary,
      ),
      selectedColor: context.colorScheme.primary,
      onSelected: (_) => onTap(),
    );
  }
}
