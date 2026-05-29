class ChangePasswordBodyModel {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  ChangePasswordBodyModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() => {
    "old_password": oldPassword,
    "new_password": newPassword,
    "confirm_password": confirmNewPassword,
  };
}
