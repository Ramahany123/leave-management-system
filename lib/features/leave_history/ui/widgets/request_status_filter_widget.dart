import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

import '../../logic/cubit/leave_history_cubit.dart';

class RequestStatusFilterWidget extends StatelessWidget {
  final String activeStatus;
  const RequestStatusFilterWidget({super.key, required this.activeStatus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemCount: RequestStatues.statues.length,
        itemBuilder: (context, index) {
          String status = RequestStatues.statues[index];
          return InkWell(
            onTap: () {
              context.read<LeaveHistoryCubit>().filterLeaveRequests(status);
            },
            child: _buildFilterItem(context, status, activeStatus),
          );
        },
      ),
    );
  }

  Widget _buildFilterItem(BuildContext context, String status, String activeStatus) {
    bool isActive = status == activeStatus;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? context.colorScheme.primary : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isActive ? context.colorScheme.primary : context.colorScheme.outline,
        ),
      ),
      child: Center(
        child: Text(
          status,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isActive
                ? Colors.white
                : context.colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
