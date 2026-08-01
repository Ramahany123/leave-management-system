import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';

import '../../data/models/task_detail_model.dart';

class TaskEmployeeBalanceCard extends StatelessWidget {
  final TaskDetailsModel taskDetails;
  const TaskEmployeeBalanceCard({super.key, required this.taskDetails});

  @override
  Widget build(BuildContext context) {
    final balance = taskDetails.employeeBalance;
    final bool canProgress = balance.total != 0;
    return InfoSection(
      title: "Leave Balance",
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _InfoColumn(days: balance.remaining, name: "Remaining"),
                  _InfoColumn(
                    days: balance.used,
                    name: "Used",
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  _InfoColumn(
                    days: balance.total,
                    name: "Total",
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              if (canProgress) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: LinearProgressIndicator(
                    minHeight: 6.h,
                    value: balance.used / balance.total,
                    backgroundColor: context.colorScheme.outline.withValues(
                      alpha: 0.2,
                    ),
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String name;
  final int days;
  final Color? color;
  const _InfoColumn({required this.name, required this.days, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: context.textTheme.titleSmall),
        Text(
          "$days Days",
          style: context.textTheme.titleLarge!.copyWith(
            color: color ?? context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
