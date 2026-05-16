import 'package:leave_management_system/features/employee_dashboard/data/models/leave_balance_model.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/recent_request_model.dart';

class EmployeeDashboardResponseModel {
  final String status;
  final List<LeaveBalanceModel> leaveBalances;
  final List<RecentRequestModel> recentRequests;

  EmployeeDashboardResponseModel({
    required this.status,
    required this.leaveBalances,
    required this.recentRequests,
  });

  factory EmployeeDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] as Map<String, dynamic>;
    return EmployeeDashboardResponseModel(
      status: json["status"],
      leaveBalances: (data["leaveBalances"] as List)
          .map((i) => LeaveBalanceModel.fromJson(i))
          .toList(),
      recentRequests: (data["recentRequests"] as List)
          .map((i) => RecentRequestModel.fromJson(i))
          .toList(),
    );
  }
}
