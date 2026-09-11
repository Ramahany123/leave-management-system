import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/create_user_request_model.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/update_user_request_model.dart';

class AdminUserWebServices {
  final ApiService _apiService;

  AdminUserWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<AdminUserResponseModel> getAllUsers() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminAllUsers,
    );
    return AdminUserResponseModel.fromJson(response.data);
  }

  Future<AdminUserModel> getUser(int id) async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminUser(id),
    );
    return AdminUserModel.fromJson(response.data["data"]);
  }

  Future<void> createUser(CreateUserRequestModel requestBody) async {
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.adminAllUsers,
      data: requestBody.toJson(),
    );
  }

  Future<void> updateUser(UpdateUserRequestModel requestBody, int id) async {
    await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.adminUser(id),
      data: requestBody.toJson(),
    );
  }

  Future<void> deleteUser(int id) async {
    await _apiService.deleteRequest(apiEndpoint: ApiEndpoints.adminUser(id));
  }
}
