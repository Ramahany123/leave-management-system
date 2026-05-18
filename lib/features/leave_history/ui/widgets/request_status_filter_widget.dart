import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';

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
        itemCount: RequestStatus.statues.length,
        itemBuilder: (context, index) {
          String status = RequestStatus.statues[index];
          return InkWell(
            onTap: () {
              context.read<LeaveHistoryCubit>().filterLeaveRequests(status);
            },
            child: _buildFilterItem(status, activeStatus),
          );
        },
      ),
    );
  }
}

Widget _buildFilterItem(String status, String activeStatus) {
  bool isActive = status == activeStatus;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: isActive ? AppColors.primaryBlue : AppColors.whiteColor,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.cardBorderColor),
    ),
    child: Text(
      status,
      style: AppTextStyles.grey16w400TextStyle.copyWith(
        color: isActive ? AppColors.whiteColor : AppColors.greyColor,
      ),
    ),
  );
}
