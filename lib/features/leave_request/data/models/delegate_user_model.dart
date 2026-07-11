class DelegateUsersResponseModel {
  final String status;
  final List<DelegateUserModel> delegateUsers;

  DelegateUsersResponseModel({
    required this.status,
    required this.delegateUsers,
  });

  factory DelegateUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      DelegateUsersResponseModel(
        status: json['status'] as String,
        delegateUsers:
            (json['data'] as List<dynamic>?)
                ?.map((e) => DelegateUserModel.fromJson(e))
                .toList() ??
            [],
      );
}

class DelegateUserModel {
  final int userId;
  final String name;
  final String jobTitle;
  final String role;

  DelegateUserModel({
    required this.userId,
    required this.name,
    required this.jobTitle,
    required this.role,
  });

  factory DelegateUserModel.fromJson(Map<String, dynamic> json) {
    return DelegateUserModel(
      userId: json['user_id'] as int,
      name: json['name'] as String,
      jobTitle: json['job_title'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }
}
