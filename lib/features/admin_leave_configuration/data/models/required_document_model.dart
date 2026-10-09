class RequiredDocument {
  final int? documentRequirementId;

  final String documentName;
  final bool isMandatory;

  RequiredDocument({
    this.documentRequirementId,

    required this.documentName,
    required this.isMandatory,
  });

  factory RequiredDocument.fromJson(Map<String, dynamic> json) {
    return RequiredDocument(
      documentRequirementId: json['document_requirement_id'] as int?,

      documentName: json['document_name'] as String,
      isMandatory: json['is_mandatory'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_requirement_id': documentRequirementId,

      'document_name': documentName,
      'is_mandatory': isMandatory,
    };
  }
}
