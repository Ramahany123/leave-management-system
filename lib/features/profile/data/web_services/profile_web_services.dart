import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/profile/data/models/profile_response_model.dart';

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
}
