class EligibilityRuleList {
  final List<EligibilityRule> list;

  EligibilityRuleList({required this.list});

  factory EligibilityRuleList.fromJson(Map<String, dynamic> json) {
    return EligibilityRuleList(
      list: (json['data'] as List<dynamic>)
          .map((e) => EligibilityRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EligibilityRule {
  final int eligibilityId;
  final int leaveTypeId;
  final String eligibleUserType;

  /// Partial embedding — see [EligibilityLeaveTypeRef].
  final EligibilityLeaveTypeRef leaveType;

  EligibilityRule({
    required this.eligibilityId,
    required this.leaveTypeId,
    required this.eligibleUserType,
    required this.leaveType,
  });

  factory EligibilityRule.fromJson(Map<String, dynamic> json) {
    return EligibilityRule(
      eligibilityId: json['eligibility_id'] as int,
      leaveTypeId: json['leave_type_id'] as int,
      eligibleUserType: json['eligible_user_type'] as String,
      leaveType: EligibilityLeaveTypeRef.fromJson(
        json['leaveType'] as Map<String, dynamic>,
      ),
    );
  }
}

class EligibilityLeaveTypeRef {
  final String typeName;
  final String? category; // nullable — leave types can be uncategorized

  EligibilityLeaveTypeRef({required this.typeName, this.category});

  factory EligibilityLeaveTypeRef.fromJson(Map<String, dynamic> json) {
    return EligibilityLeaveTypeRef(
      typeName: json['type_name'] as String,
      category: json['category'] as String?,
    );
  }
}
