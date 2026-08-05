import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/manager_coverage/data/models/team_on_leave_model.dart';
import 'package:leave_management_system/features/manager_coverage/data/web_services/manager_coverage_web_services.dart';

import '../../../../core/utils/result.dart';

class ManagerCoverageRepo {
  final ManagerCoverageWebServices _coverageWebServices;

  ManagerCoverageRepo({
    required ManagerCoverageWebServices converageWebServices,
  }) : _coverageWebServices = converageWebServices;

  Future<Result<TeamOnLeaveModel>> getTeamOnLeave({String? date}) async {
    try {
      final result = await _coverageWebServices.getTeamOnLeave(date: date);
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
