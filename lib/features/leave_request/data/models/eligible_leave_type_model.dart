class EligibleLeaveTypesResponseModel {
  final String status;
  final List<EligibleLeaveTypeModel> eligibleLeaveTypes;

  EligibleLeaveTypesResponseModel({
    required this.status,
    required this.eligibleLeaveTypes,
  });

  factory EligibleLeaveTypesResponseModel.fromJson(Map<String, dynamic> json) {
    return EligibleLeaveTypesResponseModel(
      status: json['status'] as String,
      eligibleLeaveTypes:
          (json["data"] as List<dynamic>?)
              ?.map((e) => EligibleLeaveTypeModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class EligibleLeaveTypeModel {
  final int typeId;
  final String typeName;
  final String description;
  final bool requiresDocument;
  final bool requiresDelegate;
  final int fixedBalance;
  final bool isPaid;
  final bool deductFromBalance;
  final int? lifetimeLimit;
  final int yearsOfServiceRequired;
  final int? maxDaysPerRequest;
  final int minDaysDuration;
  final List<RequiredDocumentModel> requiredDocuments;

  EligibleLeaveTypeModel({
    required this.typeId,
    required this.typeName,
    required this.description,
    required this.requiresDocument,
    required this.requiresDelegate,
    required this.fixedBalance,
    required this.isPaid,
    required this.deductFromBalance,
    this.lifetimeLimit,
    required this.yearsOfServiceRequired,
    this.maxDaysPerRequest,
    required this.minDaysDuration,
    required this.requiredDocuments,
  });

  factory EligibleLeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return EligibleLeaveTypeModel(
      typeId: json['type_id'] as int,
      typeName: json['type_name'] as String,
      description: json['description'] as String? ?? '',
      requiresDocument: json['requires_document'] as bool? ?? false,
      requiresDelegate: json['requires_delegate'] as bool? ?? false,
      fixedBalance: json['fixed_balance'] as int? ?? 0,
      isPaid: json['is_paid'] as bool? ?? false,
      deductFromBalance: json['deduct_from_balance'] as bool? ?? false,
      lifetimeLimit: json['lifetime_limit'] as int?,
      yearsOfServiceRequired: json['years_of_service_required'] as int? ?? 0,
      maxDaysPerRequest: json['max_days_per_request'] as int?,
      minDaysDuration: json['min_days_duration'] as int? ?? 1,
      requiredDocuments:
          (json['requiredDocuments'] as List<dynamic>?)
              ?.map(
                (e) =>
                    RequiredDocumentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class RequiredDocumentModel {
  final int documentRequirementId;
  final String documentName;
  final bool isMandatory;

  RequiredDocumentModel({
    required this.documentRequirementId,
    required this.documentName,
    required this.isMandatory,
  });

  factory RequiredDocumentModel.fromJson(Map<String, dynamic> json) {
    return RequiredDocumentModel(
      documentRequirementId: json['document_requirement_id'] as int,
      documentName: json['document_name'] as String,
      isMandatory: json['is_mandatory'] as bool? ?? false,
    );
  }
}
