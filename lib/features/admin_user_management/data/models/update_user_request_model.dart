import 'package:leave_management_system/core/utils/date_extension.dart';

class UpdateUserRequestModel {
  final String? name;
  final String? email;
  final String? ssn;
  final String? role;
  final String? jobTitle;
  final String? workplace;
  final String? userType;
  final DateTime? hireDate;
  final DateTime? dateOfBirth;
  final int? departmentId;
  final int? collegeId;
  final String? gender;
  final bool? isActive;
  final String? phone;
  final String? signatureUrl;

  UpdateUserRequestModel(
    this.phone,
    this.signatureUrl, {
    this.name,
    this.email,
    this.ssn,
    this.role,
    this.jobTitle,
    this.workplace,
    this.userType,
    this.hireDate,
    this.dateOfBirth,
    this.departmentId,
    this.collegeId,
    this.gender,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "ssn": ssn,
      "name": name,
      "email": email,
      "phone": phone,
      "signature_url": signatureUrl,
      "job_title": jobTitle,
      "workplace": workplace,
      "role": role,
      "user_type": userType,
      "hire_date": hireDate?.toApiDate,
      "date_of_birth": dateOfBirth?.toApiDate,
      "gender": gender,
      "department_id": departmentId,
      "college_id": collegeId,
      "is_active": isActive,
    };
    jsonMap.removeWhere((key, value) => value == null);
    return jsonMap;
  }
}
