class UploadSignatureResponseModel {
  final String signatureUrl;

  UploadSignatureResponseModel({required this.signatureUrl});

  factory UploadSignatureResponseModel.fromJson(Map<String, dynamic> json) =>
      UploadSignatureResponseModel(signatureUrl: json["data"]["signature_url"]);
}
