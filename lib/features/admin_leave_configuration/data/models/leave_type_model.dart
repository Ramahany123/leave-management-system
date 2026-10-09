import 'required_document_model.dart';
import 'work_flow_step_model.dart';

class LeaveTypeList {
  final List<LeaveType> list;

  LeaveTypeList({required this.list});

  factory LeaveTypeList.fromJson(Map<String, dynamic> json) {
    return LeaveTypeList(
      list: (json['data'] as List<dynamic>)
          .map((e) => LeaveType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LeaveType {
  final int typeId;
  final String typeName;
  final String? category;
  final String balanceType;
  final num? fixedBalance;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<WorkflowStep> workflow;
  final List<RequiredDocument> requiredDocuments;

  LeaveType({
    required this.typeId,
    required this.typeName,
    this.category,
    required this.balanceType,
    required this.fixedBalance,
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
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.workflow,
    required this.requiredDocuments,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      typeId: json['type_id'] as int,
      typeName: json['type_name'] as String,
      category: json['category'] as String?,
      balanceType: json['balance_type'] as String,
      fixedBalance: json['fixed_balance'] as num?,
      isPaid: json['is_paid'] as bool,
      deductFromBalance: json['deduct_from_balance'] as bool,
      lifetimeLimit: json['lifetime_limit'] as int?,
      yearsOfServiceRequired: json['years_of_service_required'] as int,
      minDaysDuration: json['min_days_duration'] as int,
      requiredGapDays: json['required_gap_days'] as int,
      maxDaysPerRequest: json['max_days_per_request'] as int?,
      description: json['description'] as String?,
      requiresDocument: json['requires_document'] as bool,
      requiresDelegate: json['requires_delegate'] as bool,
      genderPolicy: json['gender_policy'] as String,
      calculationMethod: json['calculation_method'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'] as String)
          : null,
      workflow: (json['workflow'] as List<dynamic>)
          .map((e) => WorkflowStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiredDocuments: (json['requiredDocuments'] as List<dynamic>)
          .map((e) => RequiredDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
