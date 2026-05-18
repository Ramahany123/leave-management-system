import 'package:leave_management_system/core/constants/enums.dart';

import '../../../../core/models/user_model.dart';

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
