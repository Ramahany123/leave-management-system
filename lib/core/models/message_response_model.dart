class MessageResponseModel {
  final String status;
  final String message;

  MessageResponseModel({required this.status, required this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      status: json['status'] as String,
      message: json['data']['message'] as String,
    );
  }
}
