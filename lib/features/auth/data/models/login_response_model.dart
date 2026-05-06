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
  final int id;
  final String email;

  UserModel({required this.id, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(id: json["user_id"] ?? 0, email: json["email"] ?? "");
}
