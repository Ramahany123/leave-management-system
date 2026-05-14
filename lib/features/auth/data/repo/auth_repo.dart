import 'package:flutter/widgets.dart';
import 'package:leave_management_system/core/cache/secure_storage_helper.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/auth/data/models/activation_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/activation_response_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_response_model.dart';
import 'package:leave_management_system/features/auth/data/web_services/auth_web_services.dart';

import '../../../../core/cache/cache_helper.dart';

class AuthRepo extends ChangeNotifier {
  final AuthWebServices _authWebServices;

  AuthStatus _currentAuthStatus = AuthStatus.unauthenticated;
  AuthStatus get currentAuthStatus => _currentAuthStatus;

  String _userRole = UserRoles.employeeRole;
  String get userRole => _userRole;

  AuthRepo({required AuthWebServices authWebServices})
    : _authWebServices = authWebServices;

  Future<void> checkInitialAuthStatus() async {
    final String? token = await SecureStorageHelper.getData(
      key: CacheKeys.userToken,
    );
    final String? statusName = CacheHelper.getData(key: CacheKeys.authStatus);
    final String? userRole = CacheHelper.getData(key: CacheKeys.userRole);

    if (token != null && token.isNotEmpty && statusName != null) {
      try {
        _currentAuthStatus = AuthStatus.values.byName(statusName);
      } catch (e) {
        _currentAuthStatus = AuthStatus.authenticated;
      }
    } else {
      _currentAuthStatus = AuthStatus.unauthenticated;
    }

    if (userRole != null) {
      _userRole = userRole;
    }
    notifyListeners();
  }

  Future<Result<LoginResponseModel>> login(LoginBodyModel loginBody) async {
    try {
      final response = await _authWebServices.login(loginBody: loginBody);
      if (response.status == AuthStatus.authenticated ||
          response.status == AuthStatus.activationRequired) {
        await SecureStorageHelper.setData(
          key: CacheKeys.userToken,
          value: response.token,
        );
        await CacheHelper.saveData(
          key: CacheKeys.authStatus,
          value: response.status.name,
        );
        if (response.user != null) {
          await CacheHelper.saveData(
            key: CacheKeys.userRole,
            value: response.user!.role,
          );
          _userRole = response.user!.role;
        }
        _currentAuthStatus = response.status;
        notifyListeners();
      }

      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<ActivationResponseModel>> activateUser(
    ActivationBodyModel activationBody,
  ) async {
    try {
      final response = await _authWebServices.activateUser(
        activationBody: activationBody,
      );
      await SecureStorageHelper.setData(
        key: CacheKeys.userToken,
        value: response.token,
      );
      await CacheHelper.saveData(
        key: CacheKeys.authStatus,
        value: response.status.name,
      );
      await CacheHelper.saveData(
        key: CacheKeys.userRole,
        value: response.user.role,
      );
      _currentAuthStatus = response.status;
      _userRole = response.user.role;
      notifyListeners();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
