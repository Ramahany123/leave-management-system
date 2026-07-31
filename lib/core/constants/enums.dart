enum AuthStatus { activationRequired, authenticated, unauthenticated, initial }

enum ViewMode { employee, manager }

enum ApprovalRole {
  headOfDepartment('Head_of_Department'),
  manager('Manager'),
  departmentCouncil('Department_Council'),
  facultyCouncil('Faculty_Council'),
  universityCouncil('University_Council'),
  unknown('');

  final String rawValue;
  const ApprovalRole(this.rawValue);

  bool get isCouncil =>
      this == ApprovalRole.departmentCouncil ||
      this == ApprovalRole.facultyCouncil ||
      this == ApprovalRole.universityCouncil;

  static ApprovalRole fromString(String? role) {
    if (role == null) return ApprovalRole.unknown;
    return ApprovalRole.values.firstWhere(
      (approvalrole) =>
          approvalrole.rawValue.toLowerCase() == role.trim().toLowerCase(),
      orElse: () => ApprovalRole.unknown,
    );
  }
}
