import 'package:leave_management_system/core/utils/handle_repository_call.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/web_services/leave_type_web_service.dart';

import '../../../../core/utils/result.dart';
import '../models/create_leave_type_request_model.dart';
import '../models/update_leave_type_request_model.dart';

class LeaveTypeRepo {
  final LeaveTypeWebService _webService;

  LeaveTypeRepo({required LeaveTypeWebService webService})
    : _webService = webService;

  Future<Result<LeaveTypeList>> getLeaveTypes() async {
    return handleRepositoryCall(_webService.getLeaveTypes);
  }

  Future<Result<void>> createLeaveType({
    required CreateLeaveTypeRequestModel requestBody,
  }) async {
    return handleRepositoryCall(
      () => _webService.createLeaveType(requestBody: requestBody),
    );
  }

  Future<Result<void>> updateLeaveType(
    int id, {
    required UpdateLeaveTypeRequestModel requestBody,
  }) async {
    return handleRepositoryCall(
      () => _webService.updateLeaveType(id, requestBody: requestBody),
    );
  }

  Future<Result<void>> deleteLeaveType(int id) async {
    return handleRepositoryCall(() => _webService.deleteLeaveType(id));
  }
}
