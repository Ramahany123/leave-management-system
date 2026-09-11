import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';
import 'package:leave_management_system/features/admin_user_management/data/web_services/admin_user_web_services.dart';

import '../../../../core/utils/result.dart';
import '../models/create_user_request_model.dart';
import '../models/update_user_request_model.dart';

class AdminUserRepo {
  final AdminUserWebServices _webServices;

  AdminUserRepo({required AdminUserWebServices userWebServices})
    : _webServices = userWebServices;

  Future<Result<AdminUserResponseModel>> getAllUsers() async {
    try {
      final result = await _webServices.getAllUsers();
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<AdminUserModel>> getUser(int id) async {
    try {
      final result = await _webServices.getUser(id);
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> createUser(CreateUserRequestModel requestBody) async {
    try {
      await _webServices.createUser(requestBody);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> updateUser(
    UpdateUserRequestModel requestBody,
    int id,
  ) async {
    try {
      await _webServices.updateUser(requestBody, id);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> deleteUser(int id) async {
    try {
      await _webServices.deleteUser(id);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
