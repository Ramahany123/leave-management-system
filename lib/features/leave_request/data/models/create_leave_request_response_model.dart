class CreateLeaveRequestResponseModel {
  final String status;
  final int requestId;

  CreateLeaveRequestResponseModel({
    required this.status,
    required this.requestId,
  });

  factory CreateLeaveRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateLeaveRequestResponseModel(
      status: json['status'] as String,
      requestId: json['data']['request_id'] as int,
    );
  }
}
