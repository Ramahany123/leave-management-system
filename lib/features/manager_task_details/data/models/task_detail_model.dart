class TaskDetailsModel {
  final int taskId;
  final String status;
  final String roleAtApproval;
  final int? sessionNumber;
  final String? sessionDate;
  final ApproverModel approver;
  final TaskRequestModel request;
  final EmployeeModel employee;
  final List<HistoryStepModel> history;
  final EmployeeBalanceModel employeeBalance;

  const TaskDetailsModel({
    required this.taskId,
    required this.status,
    required this.roleAtApproval,
    this.sessionNumber,
    this.sessionDate,
    required this.approver,
    required this.request,
    required this.employee,
    required this.history,
    required this.employeeBalance,
  });

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"]["data"];
    return TaskDetailsModel(
      taskId: data['taskId'] as int,
      status: data['status'] as String,
      roleAtApproval: data['role_at_approval'] as String,
      sessionNumber: data['session_number'] as int?,
      sessionDate: data['session_date'] as String?,
      approver: ApproverModel.fromJson(
        data['approver'] as Map<String, dynamic>,
      ),
      request: TaskRequestModel.fromJson(
        data['request'] as Map<String, dynamic>,
      ),
      employee: EmployeeModel.fromJson(
        data['employee'] as Map<String, dynamic>,
      ),
      history: (data['history'] as List<dynamic>)
          .map((e) => HistoryStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeBalance: EmployeeBalanceModel.fromJson(
        data['employeeBalance'] as Map<String, dynamic>,
      ),
    );
  }
}

class ApproverModel {
  final String name;
  final String role;

  const ApproverModel({required this.name, required this.role});

  factory ApproverModel.fromJson(Map<String, dynamic> json) {
    return ApproverModel(
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }
}

class TaskRequestModel {
  final int id;
  final String startDate;
  final String endDate;
  final int duration;
  final String reason;
  final String type;
  final DelegateModel? delegate;
  final List<AttachmentModel> attachments;

  const TaskRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.reason,
    required this.type,
    this.delegate,
    this.attachments = const [],
  });

  factory TaskRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskRequestModel(
      id: json['id'] as int,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      duration: json['duration'] as int,
      reason: json['reason'] as String,
      type: json['type'] as String,
      delegate: json['delegate'] != null
          ? DelegateModel.fromJson(json['delegate'] as Map<String, dynamic>)
          : null,
      attachments: (json['attachments'] as List<dynamic>)
          .map((i) => AttachmentModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AttachmentModel {
  final String fileName;
  final String filePath;

  const AttachmentModel({required this.fileName, required this.filePath});

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
    );
  }
}

class DelegateModel {
  final String name;
  final String email;

  DelegateModel({required this.name, required this.email});

  factory DelegateModel.fromJson(Map<String, dynamic> json) {
    return DelegateModel(name: json["name"], email: json["email"]);
  }
}

class EmployeeModel {
  final int id;
  final String name;
  final String email;
  final String signatureUrl;
  final String department;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.signatureUrl,
    required this.department,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      signatureUrl: json['signature_url'] as String,
      department: json['department'] as String,
    );
  }
}

class HistoryStepModel {
  final int step;
  final String status;
  final String? comments;
  final String roleAtApproval;
  final int? sessionNumber;
  final String? sessionDate;
  final String approver;
  final String role;
  final String? signatureUrl;

  const HistoryStepModel({
    required this.step,
    required this.status,
    this.comments,
    required this.roleAtApproval,
    this.sessionNumber,
    this.sessionDate,
    required this.approver,
    required this.role,
    this.signatureUrl,
  });

  factory HistoryStepModel.fromJson(Map<String, dynamic> json) {
    return HistoryStepModel(
      step: json['step'] as int,
      status: json['status'] as String,
      comments: json['comments'] as String?,
      roleAtApproval: json['role_at_approval'] as String,
      sessionNumber: json['session_number'] as int?,
      sessionDate: json['session_date'] as String?,
      approver: json['approver'] as String,
      role: json['role'] as String,
      signatureUrl: json['signature_url'] as String?,
    );
  }
}

class EmployeeBalanceModel {
  final int year;
  final int total;
  final int used;
  final int remaining;

  const EmployeeBalanceModel({
    required this.year,
    required this.total,
    required this.used,
    required this.remaining,
  });

  factory EmployeeBalanceModel.fromJson(Map<String, dynamic> json) {
    return EmployeeBalanceModel(
      year: json['year'] as int,
      total: json['total'] as int,
      used: json['used'] as int,
      remaining: json['remaining'] as int,
    );
  }
}
