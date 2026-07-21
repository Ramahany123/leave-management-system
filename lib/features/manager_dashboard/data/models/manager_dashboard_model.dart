import 'package:leave_management_system/features/manager_dashboard/data/models/pending_approval_model.dart';

class ManagerDashboardModel {
  final String message;
  final List<PendingApprovalModel> pendingApprovals;
  final int totalPendingTasks;

  ManagerDashboardModel({
    required this.message,
    required this.pendingApprovals,
    required this.totalPendingTasks,
  });

  factory ManagerDashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"]["data"];
    return ManagerDashboardModel(
      message: json["data"]["message"],
      pendingApprovals: (data["pendingApprovals"] as List<dynamic>)
          .map((e) => PendingApprovalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPendingTasks: data["stats"]["totalTasks"],
    );
  }
}
