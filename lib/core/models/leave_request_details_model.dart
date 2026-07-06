class LeaveRequestDetailsModel {
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
  final DetailLeaveType leaveType;
  final DetailUser user;
  final List<DetailApprovalStep> approvalSteps;
  final List<dynamic> attachments;

  LeaveRequestDetailsModel({
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
    required this.user,
    required this.approvalSteps,
    required this.attachments,
  });

  factory LeaveRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    // Robustly handle both the raw API response wrapper or just the direct 'data' block
    final Map<String, dynamic> data = json.containsKey('data')
        ? json['data'] as Map<String, dynamic>
        : json;

    return LeaveRequestDetailsModel(
      requestId: data['request_id'] as int,
      startDate: DateTime.parse(data['start_date'] as String),
      endDate: DateTime.parse(data['end_date'] as String),
      duration: data['duration'] as int,
      reason: data['reason'] ?? '',
      status: data['status'] ?? '',
      userId: data['user_id'] as int,
      typeId: data['type_id'] as int,
      preLeaveAcknowledgement:
          data['pre_leave_acknowledgement'] as bool? ?? false,
      returnedAt: data['returned_at'] != null
          ? DateTime.parse(data['returned_at'] as String)
          : null,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
      delegateUserId: data['delegate_user_id'] as int?,
      leaveType: DetailLeaveType.fromJson(
        data['leaveType'] as Map<String, dynamic>,
      ),
      user: DetailUser.fromJson(data['user'] as Map<String, dynamic>),
      approvalSteps: data['approvalSteps'] != null
          ? (data['approvalSteps'] as List)
                .map(
                  (step) =>
                      DetailApprovalStep.fromJson(step as Map<String, dynamic>),
                )
                .toList()
          : [],
      attachments: data['attachments'] as List<dynamic>? ?? [],
    );
  }
}

class DetailLeaveType {
  final int typeId;
  final String typeName;
  final String category;
  final String balanceType;
  final int? fixedBalance;
  final bool isPaid;
  final bool deductFromBalance;
  final int? lifetimeLimit;
  final int yearsOfServiceRequired;
  final int minDaysDuration;
  final int requiredGapDays;
  final int? maxDaysPerRequest;
  final String? description;
  final bool requiresDocument;
  final bool requiresDelegate;
  final String genderPolicy;
  final String calculationMethod;
  final bool isActive;

  DetailLeaveType({
    required this.typeId,
    required this.typeName,
    required this.category,
    required this.balanceType,
    this.fixedBalance,
    required this.isPaid,
    required this.deductFromBalance,
    this.lifetimeLimit,
    required this.yearsOfServiceRequired,
    required this.minDaysDuration,
    required this.requiredGapDays,
    this.maxDaysPerRequest,
    this.description,
    required this.requiresDocument,
    required this.requiresDelegate,
    required this.genderPolicy,
    required this.calculationMethod,
    required this.isActive,
  });

  factory DetailLeaveType.fromJson(Map<String, dynamic> json) {
    return DetailLeaveType(
      typeId: json['type_id'] as int,
      typeName: json['type_name'] ?? '',
      category: json['category'] ?? '',
      balanceType: json['balance_type'] ?? '',
      fixedBalance: json['fixed_balance'] as int?,
      isPaid: json['is_paid'] as bool? ?? false,
      deductFromBalance: json['deduct_from_balance'] as bool? ?? false,
      lifetimeLimit: json['lifetime_limit'] as int?,
      yearsOfServiceRequired: json['years_of_service_required'] as int? ?? 0,
      minDaysDuration: json['min_days_duration'] as int? ?? 1,
      requiredGapDays: json['required_gap_days'] as int? ?? 0,
      maxDaysPerRequest: json['max_days_per_request'] as int?,
      description: json['description'] as String?,
      requiresDocument: json['requires_document'] as bool? ?? false,
      requiresDelegate: json['requires_delegate'] as bool? ?? false,
      genderPolicy: json['gender_policy'] ?? 'All',
      calculationMethod: json['calculation_method'] ?? 'Fixed',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}

class DetailUser {
  final String name;
  final String jobTitle;
  final String? signatureUrl;
  final int collegeId;
  final DetailDepartment? department;

  DetailUser({
    required this.name,
    required this.jobTitle,
    this.signatureUrl,
    required this.collegeId,
    this.department,
  });

  factory DetailUser.fromJson(Map<String, dynamic> json) {
    return DetailUser(
      name: json['name'] ?? '',
      jobTitle: json['job_title'] ?? '',
      signatureUrl: json['signature_url'] as String?,
      collegeId: json['college_id'] as int? ?? 0,
      department: json['department'] != null
          ? DetailDepartment.fromJson(
              json['department'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class DetailDepartment {
  final int departmentId;
  final String departmentName;
  final int collegeId;
  final int? headUserId;

  DetailDepartment({
    required this.departmentId,
    required this.departmentName,
    required this.collegeId,
    this.headUserId,
  });

  factory DetailDepartment.fromJson(Map<String, dynamic> json) {
    return DetailDepartment(
      departmentId: json['department_id'] as int,
      departmentName: json['department_name'] ?? '',
      collegeId: json['college_id'] as int,
      headUserId: json['head_user_id'] as int?,
    );
  }
}

class DetailApprovalStep {
  final int stepId;
  final int stepOrder;
  final String status;
  final String? comments;
  final String? sessionNumber;
  final DateTime? sessionDate;
  final String roleAtApproval;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DetailApprover? approver;
  final String displayName;
  final bool isCouncil;

  DetailApprovalStep({
    required this.stepId,
    required this.stepOrder,
    required this.status,
    this.comments,
    this.sessionNumber,
    this.sessionDate,
    required this.roleAtApproval,
    required this.createdAt,
    required this.updatedAt,
    this.approver,
    required this.displayName,
    required this.isCouncil,
  });

  factory DetailApprovalStep.fromJson(Map<String, dynamic> json) {
    return DetailApprovalStep(
      stepId: json['step_id'] as int,
      stepOrder: json['step_order'] as int,
      status: json['status'] ?? '',
      comments: json['comments'] as String?,
      sessionNumber: json['session_number']?.toString(),
      sessionDate: json['session_date'] != null
          ? DateTime.parse(json['session_date'] as String)
          : null,
      roleAtApproval: json['role_at_approval'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      approver: json['approver'] != null
          ? DetailApprover.fromJson(json['approver'] as Map<String, dynamic>)
          : null,
      displayName: json['display_name'] ?? '',
      isCouncil: json['is_council'] as bool? ?? false,
    );
  }
}

class DetailApprover {
  final String name;
  final String? signatureUrl;
  final String role;

  DetailApprover({required this.name, this.signatureUrl, required this.role});

  factory DetailApprover.fromJson(Map<String, dynamic> json) {
    return DetailApprover(
      name: json['name'] ?? '',
      signatureUrl: json['signature_url'] as String?,
      role: json['role'] ?? '',
    );
  }
}
