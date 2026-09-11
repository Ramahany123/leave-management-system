import 'package:leave_management_system/core/utils/date_extension.dart';

class CreateUserRequestModel {
  final String name;
  final String email;
  final String ssn;
  final String role;
  final String? jobTitle;
  final String? workplace;
  final String userType;
  final DateTime hireDate;
  final DateTime dateOfBirth;
  final int departmentId;
  final int collegeId;
  final String gender;

  CreateUserRequestModel({
    required this.name,
    required this.email,
    required this.ssn,
    this.role = "Employee",
    this.jobTitle,
    this.workplace,
    required this.userType,
    required this.hireDate,
    required this.dateOfBirth,
    required this.departmentId,
    required this.collegeId,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "ssn": ssn,
    "role": role,
    "job_title": jobTitle,
    "workplace": workplace,
    "user_type": userType,
    "hire_date": hireDate.toApiDate,
    "date_of_birth": dateOfBirth.toApiDate,
    "department_id": departmentId,
    "college_id": collegeId,
    "gender": gender,
  };
}
