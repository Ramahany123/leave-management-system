class TeamOnLeaveModel {
  final int count;
  final List<TeamMemberOnLeave> employees;

  TeamOnLeaveModel({required this.count, required this.employees});

  factory TeamOnLeaveModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"]["data"];
    return TeamOnLeaveModel(
      count: data['count'] ?? 0,
      employees:
          (data['employees'] as List<dynamic>?)
              ?.map(
                (e) => TeamMemberOnLeave.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'employees': employees.map((e) => e.toJson()).toList(),
    };
  }
}

class TeamMemberOnLeave {
  final int requestId;
  final String employeeName;
  final String department;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;

  TeamMemberOnLeave({
    required this.requestId,
    required this.employeeName,
    required this.department,
    required this.leaveType,
    this.startDate,
    this.endDate,
  });

  factory TeamMemberOnLeave.fromJson(Map<String, dynamic> json) {
    return TeamMemberOnLeave(
      requestId: json['requestId'] ?? 0,
      employeeName: json['employeeName'] ?? '',
      department: json['department'] ?? '',
      leaveType: json['leaveType'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'employeeName': employeeName,
      'department': department,
      'leaveType': leaveType,
      'startDate': startDate?.toIso8601String().substring(0, 10),
      'endDate': endDate?.toIso8601String().substring(0, 10),
    };
  }
}
