import 'package:leave_management_system/core/cache/secure_storage_helper.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_response_model.dart';
import 'package:leave_management_system/features/auth/data/web_services/auth_web_services.dart';

class AuthRepo {
  final AuthWebServices _authWebServices;

  AuthRepo({required AuthWebServices authWebServices})
    : _authWebServices = authWebServices;

  Future<Result<LoginResponseModel>> login(LoginBodyModel loginBody) async {
    try {
      final response = await _authWebServices.login(loginBody: loginBody);
      if (response.status == AuthStatus.authenticated ||
          response.status == AuthStatus.activationRequired) {
        await SecureStorageHelper.setData(
          key: CacheKeys.userToken,
          value: response.token,
        );
      }
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
