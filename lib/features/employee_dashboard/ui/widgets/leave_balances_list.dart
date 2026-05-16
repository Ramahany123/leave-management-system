import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/leave_balance_model.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/widgets/leave_balance_card.dart';

class LeaveBalancesList extends StatelessWidget {
  final List<LeaveBalanceModel> leaveBalances;

  const LeaveBalancesList({super.key, required this.leaveBalances});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: leaveBalances.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final item = leaveBalances[index];
          return LeaveBalanceCard(
            taken: item.taken,
            title: item.typeName,
            balance: item.remaining,
            total: item.total,
            progressValue: item.total > 0 ? item.remaining / item.total : 0,
            isCircular: true,
          );
        },
      ),
    );
  }
}
