class LoginBodyModel {
  final String email;
  final String password;

  LoginBodyModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
