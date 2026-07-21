class PendingApprovalModel {
  final int stepId;
  final int requestId;
  final int approverId;
  final int stepOrder;
  final int? sessionNumber;
  final String? sessionDate;
  final String status;
  final String? comments;
  final String roleAtApproval;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RequestModel request;

  const PendingApprovalModel({
    required this.stepId,
    required this.requestId,
    required this.approverId,
    required this.stepOrder,
    this.sessionNumber,
    this.sessionDate,
    required this.status,
    this.comments,
    required this.roleAtApproval,
    required this.createdAt,
    required this.updatedAt,
    required this.request,
  });

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalModel(
      stepId: json['step_id'] as int,
      requestId: json['request_id'] as int,
      approverId: json['approver_id'] as int,
      stepOrder: json['step_order'] as int,
      sessionNumber: json['session_number'] as int?,
      sessionDate: json['session_date'] as String?,
      status: json['status'] as String,
      comments: json['comments'] as String?,
      roleAtApproval: json['role_at_approval'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      request: RequestModel.fromJson(json['request'] as Map<String, dynamic>),
    );
  }
}

class RequestModel {
  final int requestId;
  final DateTime startDate;
  final DateTime endDate;
  final int duration;
  final String reason;
  final String status;
  final int userId;
  final int typeId;
  final bool preLeaveAcknowledgement;
  final String? returnedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? delegateUserId;
  final PendingApprovalUserModel user;
  final String leaveTypeName;

  const RequestModel({
    required this.requestId,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.reason,
    required this.status,
    required this.userId,
    required this.typeId,
    required this.preLeaveAcknowledgement,
    this.returnedAt,
    required this.createdAt,
    required this.updatedAt,
    this.delegateUserId,
    required this.user,
    required this.leaveTypeName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestId: json['request_id'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      duration: json['duration'] as int,
      reason: json['reason'] as String,
      status: json['status'] as String,
      userId: json['user_id'] as int,
      typeId: json['type_id'] as int,
      preLeaveAcknowledgement: json['pre_leave_acknowledgement'] as bool,
      returnedAt: json['returned_at'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      delegateUserId: json['delegate_user_id'] as int?,
      user: PendingApprovalUserModel.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
      leaveTypeName: json['leaveType']["type_name"] as String,
    );
  }
}

class PendingApprovalUserModel {
  final int userId;
  final String name;
  final String email;
  final int departmentId;

  const PendingApprovalUserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.departmentId,
  });

  factory PendingApprovalUserModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalUserModel(
      userId: json['user_id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      departmentId: json['department_id'] as int,
    );
  }
}
