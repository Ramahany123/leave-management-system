class UpdateContactResponseModel {
  final String status;
  final String message;
  final String phone;

  UpdateContactResponseModel({
    required this.status,
    required this.message,
    required this.phone,
  });

  factory UpdateContactResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateContactResponseModel(
        status: json['status'] as String,
        message: json['data']['message'] as String,
        phone: json['data']["user"]["phone"] as String,
      );
}
