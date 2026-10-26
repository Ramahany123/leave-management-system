class ReportResponseModel {
  final List<ReportLeaveRequest> leaveRequests;
  final int total;

  ReportResponseModel({required this.leaveRequests, required this.total});

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] as Map<String, dynamic>;
    final requestsJson = data["data"] as List;

    return ReportResponseModel(
      leaveRequests: requestsJson
          .map(
            (item) => ReportLeaveRequest.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      total: (data["total"] as num).toInt(),
    );
  }
}

class ReportLeaveRequest {
  final int requestId;
  final DateTime startDate;
  final DateTime endDate;
  final int? duration;
  final String? reason;
  final String status;
  final int userId;
  final int typeId;
  final bool preLeaveAcknowledgement;
  final DateTime? returnedAt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final ReportUser user;
  final ReportLeaveType? leaveType;

  ReportLeaveRequest({
    required this.requestId,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.reason,
    required this.status,
    required this.userId,
    required this.typeId,
    required this.preLeaveAcknowledgement,
    required this.returnedAt,
    required this.updatedAt,
    required this.createdAt,
    required this.user,
    required this.leaveType,
  });

  factory ReportLeaveRequest.fromJson(Map<String, dynamic> json) {
    final leaveTypeJson = json["leaveType"] as Map<String, dynamic>?;

    return ReportLeaveRequest(
      requestId: json["request_id"] as int,
      startDate: DateTime.parse(json["start_date"] as String),
      endDate: DateTime.parse(json["end_date"] as String),
      duration: (json["duration"] as num?)?.toInt(),
      reason: json["reason"] as String?,
      status: (json["status"] as String?) ?? "Pending",
      userId: json["user_id"] as int,
      typeId: json["type_id"] as int,
      preLeaveAcknowledgement: json["pre_leave_acknowledgement"] as bool,
      returnedAt: json["returned_at"] == null
          ? null
          : DateTime.parse(json["returned_at"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
      createdAt: DateTime.parse(json["createdAt"] as String),
      user: ReportUser.fromJson(json["user"] as Map<String, dynamic>),
      leaveType: leaveTypeJson == null
          ? null
          : ReportLeaveType.fromJson(leaveTypeJson),
    );
  }
}

class ReportUser {
  final int userId;
  final String name;
  final String email;
  final ReportDepartment? department;

  ReportUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.department,
  });

  factory ReportUser.fromJson(Map<String, dynamic> json) {
    final departmentJson = json["department"] as Map<String, dynamic>?;

    return ReportUser(
      userId: json["user_id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      department: departmentJson == null
          ? null
          : ReportDepartment.fromJson(departmentJson),
    );
  }
}

class ReportDepartment {
  final int departmentId;
  final String name;

  ReportDepartment({required this.departmentId, required this.name});

  factory ReportDepartment.fromJson(Map<String, dynamic> json) {
    return ReportDepartment(
      departmentId: json["department_id"] as int,
      name: json["department_name"] as String,
    );
  }
}

class ReportLeaveType {
  final int typeId;
  final String name;

  ReportLeaveType({required this.typeId, required this.name});

  factory ReportLeaveType.fromJson(Map<String, dynamic> json) {
    return ReportLeaveType(
      typeId: json["type_id"] as int,
      name: json["type_name"] as String,
    );
  }
}
