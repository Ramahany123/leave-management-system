class AdminUserResponseModel {
  final bool isSuccess;
  final List<AdminUserModel> users;

  AdminUserResponseModel({required this.isSuccess, required this.users});

  factory AdminUserResponseModel.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> data = json["data"];
    return AdminUserResponseModel(
      isSuccess: json["success"],
      users: data.map((i) => AdminUserModel.fromJson(i)).toList(),
    );
  }
}

class AdminUserModel {
  final int yearsOfService;
  final int userId;
  final String ssn;
  final String name;
  final String email;
  final String? phone;
  final String? signatureUrl;
  final String? jobTitle;
  final String? workplace;
  final String role;
  final String userType;
  final DateTime hireDate;
  final DateTime dateOfBirth;
  final String? gender;
  final int? departmentId;
  final int? collegeId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? department;
  final String? college;

  AdminUserModel({
    required this.yearsOfService,
    required this.userId,
    required this.ssn,
    required this.name,
    required this.email,
    required this.phone,
    required this.signatureUrl,
    required this.jobTitle,
    required this.workplace,
    required this.role,
    required this.userType,
    required this.hireDate,
    required this.dateOfBirth,
    required this.gender,
    required this.departmentId,
    required this.collegeId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.department,
    required this.college,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) {
    return AdminUserModel(
      yearsOfService: json["yearsOfService"],
      userId: json["user_id"],
      ssn: json["ssn"].toString(),
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      signatureUrl: json["signature_url"],
      jobTitle: json["job_title"],
      workplace: json["workplace"],
      role: json["role"],
      userType: json["user_type"],
      hireDate: DateTime.parse(json["hire_date"]),
      dateOfBirth: DateTime.parse(json["date_of_birth"]),
      gender: json["gender"],
      departmentId: json["department_id"],
      collegeId: json["college_id"],
      isActive: json["is_active"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      // Extract the name string from the nested object if it isn't null
      department: json["department"] != null
          ? json["department"]["department_name"]
          : null,
      college: json["college"] != null ? json["college"]["college_name"] : null,
    );
  }
}
