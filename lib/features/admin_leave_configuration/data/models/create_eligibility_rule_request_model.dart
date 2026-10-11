class CreateEligibilityRuleRequestModel {
  final int leaveTypeId;
  final String eligibleUserType;

  CreateEligibilityRuleRequestModel({
    required this.leaveTypeId,
    required this.eligibleUserType,
  });

  Map<String, dynamic> toJson() {
    return {
      'leave_type_id': leaveTypeId,
      'eligible_user_type': eligibleUserType,
    };
  }
}
