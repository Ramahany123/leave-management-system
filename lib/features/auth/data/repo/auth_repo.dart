import 'package:flutter/widgets.dart';
import 'package:leave_management_system/core/cache/secure_storage_helper.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/core/models/message_response_model.dart';
import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/features/auth/data/models/activation_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/activation_response_model.dart';
import 'package:leave_management_system/features/auth/data/models/change_password_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_response_model.dart';
import 'package:leave_management_system/features/auth/data/web_services/auth_web_services.dart';
import 'package:leave_management_system/features/profile/data/models/profile_response_model.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';

import '../../../../core/cache/cache_helper.dart';

class AuthRepo extends ChangeNotifier {
  final AuthWebServices _authWebServices;

  AuthStatus _currentAuthStatus = AuthStatus.unauthenticated;
  AuthStatus get currentAuthStatus => _currentAuthStatus;

  String _userRole = UserRoles.employeeRole;
  String get userRole => _userRole;

  String _userName = "";
  String get userName => _userName;

  Failure? _initialAuthFailure;
  Failure? get initialAuthFailure => _initialAuthFailure;

  AuthRepo({required AuthWebServices authWebServices})
    : _authWebServices = authWebServices;

  Future<void> checkInitialAuthStatus() async {
    _initialAuthFailure = null;
    final String? token = await SecureStorageHelper.getData(
      key: CacheKeys.userToken,
    );
    final String? userRole = CacheHelper.getData(key: CacheKeys.userRole);
    final String? userName = CacheHelper.getData(key: CacheKeys.userName);

    if (userRole != null) {
      _userRole = userRole;
    }
    if (userName != null) {
      _userName = userName;
    }

    if (token == null || token.isEmpty) {
      _currentAuthStatus = AuthStatus.unauthenticated;
      notifyListeners();
      return;
    } else {
      final result = await sl<ProfileRepo>().getProfile();
      switch (result) {
        case SuccessResult<ProfileResponseModel>(:final data):
          _currentAuthStatus = data.user.isActive
              ? AuthStatus.authenticated
              : AuthStatus.activationRequired;

        case FailureResult<ProfileResponseModel>(:final failure):
          if (failure is UnauthenticatedFailure) {
            await logout();
          } else {
            _initialAuthFailure = failure;
          }
      }
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
          await CacheHelper.saveData(
            key: CacheKeys.userName,
            value: response.user!.name,
          );
          _userName = response.user!.name;
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
      await CacheHelper.saveData(
        key: CacheKeys.userName,
        value: response.user.name,
      );
      _currentAuthStatus = response.status;
      _userRole = response.user.role;
      _userName = response.user.name;
      notifyListeners();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteData(key: CacheKeys.userToken);
    await CacheHelper.removeData(key: CacheKeys.userName);
    await CacheHelper.removeData(key: CacheKeys.userRole);
    await CacheHelper.removeData(key: CacheKeys.authStatus);

    _currentAuthStatus = AuthStatus.unauthenticated;
    _userName = "";
    _userRole = UserRoles.employeeRole;

    notifyListeners();
  }

  Future<Result<MessageResponseModel>> changePassword(
    ChangePasswordBodyModel changePasswordBody,
  ) async {
    try {
      final response = await _authWebServices.changePassword(
        changePasswordBody,
      );
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
