class ActivationBodyModel {
  final String phone;
  final String password;
  final String confirmPassword;

  ActivationBodyModel({
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "new_password": password,
    "confirm_password": confirmPassword,
  };
}
