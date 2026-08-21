class DepartmentResponse {
  final int count;
  final List<Department> allDepartments;

  const DepartmentResponse({required this.count, required this.allDepartments});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      count: json['count'] as int? ?? 0,
      allDepartments: json['data'] != null
          ? (json['data'] as List<dynamic>)
                .map((e) => Department.fromJson(e as Map<String, dynamic>))
                .toList()
          : const [],
    );
  }
}

class Department {
  final int departmentId;
  final String departmentName;
  final int collegeId;
  final int? headUserId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final CollegeSummary? college;
  final DepartmentHead? head;

  const Department({
    required this.departmentId,
    required this.departmentName,
    required this.collegeId,
    required this.headUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.college,
    this.head,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      departmentId: json['department_id'] as int,
      departmentName: json['department_name'] as String,
      collegeId: json['college_id'] as int,
      headUserId: json['head_user_id'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'] as String)
          : null,
      college: json['college'] != null
          ? CollegeSummary.fromJson(json['college'] as Map<String, dynamic>)
          : null,
      head: json['head'] != null
          ? DepartmentHead.fromJson(json['head'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CollegeSummary {
  final String collegeName;

  const CollegeSummary({required this.collegeName});

  factory CollegeSummary.fromJson(Map<String, dynamic> json) {
    return CollegeSummary(collegeName: json['college_name'] as String? ?? '');
  }
}

class DepartmentHead {
  final int userId;
  final String name;

  const DepartmentHead({required this.userId, required this.name});

  factory DepartmentHead.fromJson(Map<String, dynamic> json) {
    return DepartmentHead(
      userId: json['user_id'] as int,
      name: json['name'] as String? ?? '',
    );
  }
}
