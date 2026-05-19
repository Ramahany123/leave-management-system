import 'package:leave_management_system/core/models/user_model.dart';

class ProfileResponseModel {
  final String status;
  final UserModel user;

  ProfileResponseModel({required this.status, required this.user});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        status: json["status"],
        user: UserModel.fromJson(json["data"]["user"]),
      );
}
