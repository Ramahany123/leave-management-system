import 'package:leave_management_system/core/models/leave_request_details_model.dart';
import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/leave_history/data/models/leave_history_model.dart';
import 'package:leave_management_system/features/leave_history/data/web_services/leave_history_web_services.dart';

import '../../../../core/utils/result.dart';

class LeaveHistoryRepo {
  final LeaveHistoryWebServices _leaveHistoryWebServices;

  LeaveHistoryRepo({required LeaveHistoryWebServices leaveHistoryWebServices})
    : _leaveHistoryWebServices = leaveHistoryWebServices;

  Future<Result<LeaveHistoryModel>> getLeaveHistory() async {
    try {
      final response = await _leaveHistoryWebServices.getLeaveHistory();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<LeaveRequestDetailsModel>> getLeaveRequestDetails(
    int id,
  ) async {
    try {
      final response = await _leaveHistoryWebServices.getLeaveRequestDetails(
        id,
      );
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
