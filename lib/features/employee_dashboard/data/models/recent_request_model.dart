class RecentRequestModel {
  final int requestId;
  final DateTime startDate;
  final DateTime endDate;
  final int duration;
  final String reason;
  final String status;
  final int userId;
  final int typeId;
  final bool preLeaveAcknowledgement;
  final DateTime? returnedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? delegateUserId;
  final LeaveType leaveType;

  RecentRequestModel({
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
    required this.leaveType,
  });

  factory RecentRequestModel.fromJson(Map<String, dynamic> json) {
    return RecentRequestModel(
      requestId: json['request_id'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      duration: json['duration'] as int,
      reason: json['reason'] as String,
      status: json['status'] as String,
      userId: json['user_id'] as int,
      typeId: json['type_id'] as int,
      preLeaveAcknowledgement: json['pre_leave_acknowledgement'] as bool,
      returnedAt: json['returned_at'] != null
          ? DateTime.parse(json['returned_at'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      delegateUserId: json['delegate_user_id'] as int?,
      leaveType: LeaveType.fromJson(json['leaveType'] as Map<String, dynamic>),
    );
  }
}

class LeaveType {
  final String typeName;

  LeaveType({required this.typeName});

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(typeName: json['type_name'] as String);
  }
}
