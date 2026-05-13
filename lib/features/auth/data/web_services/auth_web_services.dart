import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/auth/data/models/activation_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/activation_response_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_response_model.dart';

class AuthWebServices {
  final ApiService _apiService;

  AuthWebServices({required ApiService apiService}) : _apiService = apiService;

  Future<LoginResponseModel> login({required LoginBodyModel loginBody}) async {
    Response response = await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.login,
      data: loginBody.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }

  Future<ActivationResponseModel> activateUser({
    required ActivationBodyModel activationBody,
  }) async {
    final Response response = await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.activateUser,
      data: activationBody.toJson(),
    );
    return ActivationResponseModel.fromJson(response.data);
  }
}
