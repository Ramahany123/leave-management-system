import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/profile/data/models/profile_response_model.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_body_model.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_response_model.dart';
import 'package:leave_management_system/features/profile/data/models/upload_signature_response_model.dart';

//TODO: add option to upload signature
class ProfileWebServices {
  final ApiService _apiService;

  ProfileWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<ProfileResponseModel> getProfile() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getProfile,
    );
    return ProfileResponseModel.fromJson(response.data);
  }

  Future<UpdateContactResponseModel> updateContact(
    UpdateContactBodyModel updateContactBody,
  ) async {
    final Response response = await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.updateContact,
      data: updateContactBody.toJson(),
    );
    return UpdateContactResponseModel.fromJson(response.data);
  }

  Future<UploadSignatureResponseModel> uploadSignature(String filePath) async {
    final formData = FormData.fromMap({
      "signature": await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      ),
    });

    final Response response = await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.uploadSignature,
      data: formData,
    );
    return UploadSignatureResponseModel.fromJson(response.data);
  }
}
