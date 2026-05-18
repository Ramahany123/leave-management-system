import 'package:leave_management_system/core/models/leave_request_model.dart';

class LeaveHistoryModel {
  final String status;
  final List<LeaveRequestModel> leaveRequests;

  LeaveHistoryModel({required this.status, required this.leaveRequests});

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) =>
      LeaveHistoryModel(
        status: json["status"],
        leaveRequests: (json["data"] as List)
            .map((i) => LeaveRequestModel.fromJson(i))
            .toList(),
      );
}
