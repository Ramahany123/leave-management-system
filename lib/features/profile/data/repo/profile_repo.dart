import 'package:flutter/widgets.dart';
import 'package:leave_management_system/core/models/user_model.dart';
import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/profile/data/models/profile_response_model.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_body_model.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_response_model.dart';
import 'package:leave_management_system/features/profile/data/web_services/profile_web_services.dart';

class ProfileRepo extends ChangeNotifier {
  final ProfileWebServices _profileWebServices;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  ProfileRepo({required ProfileWebServices profileWebServices})
    : _profileWebServices = profileWebServices;

  Future<Result<ProfileResponseModel>> getProfile() async {
    try {
      final response = await _profileWebServices.getProfile();
      _currentUser = response.user;
      notifyListeners();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<UpdateContactResponseModel>> updateContact(
    UpdateContactBodyModel updateContactBody,
  ) async {
    try {
      final response = await _profileWebServices.updateContact(
        updateContactBody,
      );
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(phone: response.phone);
      } else {
        await getProfile();
      }
      notifyListeners();

      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
