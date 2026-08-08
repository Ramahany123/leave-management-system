class ManagerReportsModel {
  final Statistics statistics;
  final List<ReportRecord> reports;

  ManagerReportsModel({required this.statistics, required this.reports});

  factory ManagerReportsModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"]["data"];
    return ManagerReportsModel(
      statistics: Statistics.fromJson(data['statistics'] ?? {}),
      reports:
          (data['report'] as List<dynamic>?)
              ?.map((e) => ReportRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statistics': statistics.toJson(),
      'report': reports.map((e) => e.toJson()).toList(),
    };
  }
}

class Statistics {
  final int total;
  final int approved;
  final int rejected;
  final int pending;

  Statistics({
    required this.total,
    required this.approved,
    required this.rejected,
    required this.pending,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      total: json['total'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
      pending: json['pending'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'approved': approved,
      'rejected': rejected,
      'pending': pending,
    };
  }
}

class ReportRecord {
  final String employeeName;
  final String department;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int duration;
  final String status;
  final DateTime? createdAt;
  final List<ApproverComment> comments;

  ReportRecord({
    required this.employeeName,
    required this.department,
    required this.leaveType,
    required this.duration,
    required this.status,
    required this.comments,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory ReportRecord.fromJson(Map<String, dynamic> json) {
    return ReportRecord(
      employeeName: json['employeeName'] ?? '',
      department: json['department'] ?? '',
      leaveType: json['leaveType'] ?? '',
      duration: json['duration'] ?? 0,
      status: json['status'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => ApproverComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'department': department,
      'leaveType': leaveType,
      'startDate': startDate?.toIso8601String().substring(0, 10),
      'endDate': endDate?.toIso8601String().substring(0, 10),
      'duration': duration,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }
}

class ApproverComment {
  final String approver;
  final String role;
  final String status;
  final String comment;
  final DateTime? date;

  ApproverComment({
    required this.approver,
    required this.role,
    required this.status,
    required this.comment,
    this.date,
  });

  factory ApproverComment.fromJson(Map<String, dynamic> json) {
    return ApproverComment(
      approver: json['approver'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      comment: json['comment'] ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approver': approver,
      'role': role,
      'status': status,
      'comment': comment,
      'date': date?.toIso8601String(),
    };
  }
}
