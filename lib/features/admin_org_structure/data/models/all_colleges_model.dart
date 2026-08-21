class AllCollegesModel {
  final String status;
  final List<CollegeModel> colleges;

  const AllCollegesModel({required this.status, required this.colleges});

  factory AllCollegesModel.fromJson(Map<String, dynamic> json) {
    return AllCollegesModel(
      status: json['status'] as String,
      colleges: (json['data'] as List<dynamic>)
          .map((e) => CollegeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CollegeModel {
  final int collegeId;
  final String collegeName;
  final int? deanId;
  final int? departmentCount;
  final CollegeDeanModel? dean;
  final List<CollegeDepartmentItem> departments;

  const CollegeModel({
    required this.collegeId,
    required this.collegeName,
    required this.deanId,
    required this.departmentCount,
    required this.dean,
    required this.departments,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json.containsKey("data")
        ? json["data"] as Map<String, dynamic>
        : json;
    return CollegeModel(
      collegeId: data["college_id"] as int,
      collegeName: data["college_name"] as String,
      deanId: data["dean_user_id"] as int?,
      departmentCount: data["departmentCount"] as int?,
      dean: data["dean"] != null
          ? CollegeDeanModel.fromJson(data["dean"] as Map<String, dynamic>)
          : null,
      departments: data["departments"] != null
          ? (data["departments"] as List<dynamic>)
                .map(
                  (i) =>
                      CollegeDepartmentItem.fromJson(i as Map<String, dynamic>),
                )
                .toList()
          : const [],
    );
  }
}

class CollegeDeanModel {
  final int deanId;
  final String name;
  final String email;

  const CollegeDeanModel({
    required this.deanId,
    required this.name,
    required this.email,
  });

  factory CollegeDeanModel.fromJson(Map<String, dynamic> json) {
    return CollegeDeanModel(
      deanId: json["user_id"] as int? ?? 0,
      name: json["name"] as String? ?? "",
      email: json["email"] as String? ?? "",
    );
  }
}

class CollegeDepartmentItem {
  final int departmentId;
  final String departmentName;

  const CollegeDepartmentItem({
    required this.departmentId,
    required this.departmentName,
  });

  factory CollegeDepartmentItem.fromJson(Map<String, dynamic> json) {
    return CollegeDepartmentItem(
      departmentId: json["department_id"] as int? ?? 0,
      departmentName: json["department_name"] as String? ?? "",
    );
  }
}
