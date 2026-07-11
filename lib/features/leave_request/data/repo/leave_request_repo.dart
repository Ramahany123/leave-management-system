import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/leave_request/data/models/create_leave_request_response_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/delegate_user_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/eligible_leave_type_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/leave_requet_body_model.dart';
import 'package:leave_management_system/features/leave_request/data/web_services/leave_request_web_services.dart';

import '../../../../core/utils/result.dart';

class LeaveRequestRepo {
  final LeaveRequestWebServices _leaveRequestWebServices;

  LeaveRequestRepo({required LeaveRequestWebServices leaveRequestWebServices})
    : _leaveRequestWebServices = leaveRequestWebServices;

  Future<Result<EligibleLeaveTypesResponseModel>>
  getEligibleLeaveTypes() async {
    try {
      final response = await _leaveRequestWebServices.getEligibleLeaveTypes();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<DelegateUsersResponseModel>> getDelegateUsers() async {
    try {
      final response = await _leaveRequestWebServices.getDelegateUsers();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<CreateLeaveRequestResponseModel>> createLeaveRequest(
    LeaveRequestBodyModel body,
  ) async {
    try {
      final response = await _leaveRequestWebServices.createLeaveRequest(body);
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
