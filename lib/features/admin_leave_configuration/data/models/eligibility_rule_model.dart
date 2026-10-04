class LeaveEligibilityResponse {
  final String status;
  final List<LeaveEligibility> data;

  LeaveEligibilityResponse({required this.status, required this.data});

  factory LeaveEligibilityResponse.fromJson(Map<String, dynamic> json) {
    return LeaveEligibilityResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => LeaveEligibility.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class LeaveEligibility {
  final int eligibilityId;
  final int leaveTypeId;
  final String eligibleUserType;
  final LeaveTypeSummary leaveType;

  LeaveEligibility({
    required this.eligibilityId,
    required this.leaveTypeId,
    required this.eligibleUserType,
    required this.leaveType,
  });

  factory LeaveEligibility.fromJson(Map<String, dynamic> json) {
    return LeaveEligibility(
      eligibilityId: json['eligibility_id'] as int,
      leaveTypeId: json['leave_type_id'] as int,
      eligibleUserType: json['eligible_user_type'] as String,
      leaveType: LeaveTypeSummary.fromJson(
        json['leaveType'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eligibility_id': eligibilityId,
      'leave_type_id': leaveTypeId,
      'eligible_user_type': eligibleUserType,
      'leaveType': leaveType.toJson(),
    };
  }
}

class LeaveTypeSummary {
  final String typeName;
  final String category;

  LeaveTypeSummary({required this.typeName, required this.category});

  factory LeaveTypeSummary.fromJson(Map<String, dynamic> json) {
    return LeaveTypeSummary(
      typeName: json['type_name'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type_name': typeName, 'category': category};
  }
}
