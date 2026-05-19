import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/profile/data/models/profile_response_model.dart';
import 'package:leave_management_system/features/profile/data/web_services/profile_web_services.dart';

class ProfileRepo {
  final ProfileWebServices _profileWebServices;

  ProfileRepo({required ProfileWebServices profileWebServices})
    : _profileWebServices = profileWebServices;

  Future<Result<ProfileResponseModel>> getProfile() async {
    try {
      final response = await _profileWebServices.getProfile();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
