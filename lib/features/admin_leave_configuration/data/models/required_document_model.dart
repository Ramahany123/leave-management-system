class RequiredDocument {
  final int? documentRequirementId;
  final int leaveTypeId;
  final String documentName;
  final bool isMandatory;

  RequiredDocument({
    this.documentRequirementId,
    required this.leaveTypeId,
    required this.documentName,
    required this.isMandatory,
  });

  factory RequiredDocument.fromJson(Map<String, dynamic> json) {
    return RequiredDocument(
      documentRequirementId: json['document_requirement_id'] as int?,
      leaveTypeId: json['leave_type_id'] as int,
      documentName: json['document_name'] as String,
      isMandatory: json['is_mandatory'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_requirement_id': documentRequirementId,
      'leave_type_id': leaveTypeId,
      'document_name': documentName,
      'is_mandatory': isMandatory,
    };
  }
}
