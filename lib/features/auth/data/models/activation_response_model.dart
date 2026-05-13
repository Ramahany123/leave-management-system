import '../../../../core/constants/enums.dart';
import 'login_response_model.dart';

class ActivationResponseModel {
  final String message;
  final String token;
  final AuthStatus status;
  final UserModel user;

  ActivationResponseModel({
    required this.message,
    required this.token,
    required this.status,
    required this.user,
  });

  factory ActivationResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final innerData = data["user"];

    return ActivationResponseModel(
      message: data["message"] ?? "",
      token: innerData["token"] ?? "",
      status: AuthStatus.authenticated,
      user: UserModel.fromJson(innerData["user"]),
    );
  }
}
