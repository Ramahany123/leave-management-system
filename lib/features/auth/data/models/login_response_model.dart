import 'package:leave_management_system/core/constants/enums.dart';

class LoginResponseModel {
  final AuthStatus status;
  final String token;
  final UserModel? user;

  LoginResponseModel({required this.status, required this.token, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data = json["data"];
    AuthStatus authStatus;
    switch (data?["status"]) {
      case 'authenticated':
        authStatus = AuthStatus.authenticated;
        break;
      case 'activation_required':
        authStatus = AuthStatus.activationRequired;
        break;
      default:
        authStatus = AuthStatus.unauthenticated;
        break;
    }
    return LoginResponseModel(
      status: authStatus,
      token: data?["token"] ?? "",
      user: data?['user'] != null ? UserModel.fromJson(data!['user']) : null,
    );
  }
}

class UserModel {
  final int yearsOfService;
  final int userId;
  final int ssn;
  final String name;
  final String? passwordResetToken;
  final DateTime? passwordResetExpires;
  final String email;
  final String phone;
  final String? signatureUrl;
  final String jobTitle;
  final String workplace;
  final String role;
  final String userType;
  final DateTime hireDate;
  final DateTime dateOfBirth;
  final String gender;
  final int departmentId;
  final int collegeId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  UserModel({
    required this.yearsOfService,
    required this.userId,
    required this.ssn,
    required this.name,
    this.passwordResetToken,
    this.passwordResetExpires,
    required this.email,
    required this.phone,
    this.signatureUrl,
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
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      yearsOfService: json['yearsOfService'] as int,
      userId: json['user_id'] as int,
      ssn: json['ssn'] as int,
      name: json['name'] as String,
      passwordResetToken: json['password_reset_token'] as String?,
      passwordResetExpires: json['password_reset_expires'] != null
          ? DateTime.parse(json['password_reset_expires'] as String)
          : null,
      email: json['email'] as String,
      phone: json['phone'] as String,
      signatureUrl: json['signature_url'] as String?,
      jobTitle: json['job_title'] as String,
      workplace: json['workplace'] as String,
      role: json['role'] as String,
      userType: json['user_type'] as String,
      hireDate: DateTime.parse(json['hire_date'] as String),
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as String,
      departmentId: json['department_id'] as int,
      collegeId: json['college_id'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'yearsOfService': yearsOfService,
      'user_id': userId,
      'ssn': ssn,
      'name': name,
      'password_reset_token': passwordResetToken,
      'password_reset_expires': passwordResetExpires?.toIso8601String(),
      'email': email,
      'phone': phone,
      'signature_url': signatureUrl,
      'job_title': jobTitle,
      'workplace': workplace,
      'role': role,
      'user_type': userType,
      'hire_date': hireDate.toIso8601String().split('T').first,
      'date_of_birth': dateOfBirth.toIso8601String().split('T').first,
      'gender': gender,
      'department_id': departmentId,
      'college_id': collegeId,
      'is_active': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
