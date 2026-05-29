class UpdateContactBodyModel {
  final String phone;
  final String password;

  UpdateContactBodyModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "current_password": password,
  };
}
