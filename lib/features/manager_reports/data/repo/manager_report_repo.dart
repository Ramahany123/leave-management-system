import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/manager_reports/data/models/manager_reports_model.dart';
import 'package:leave_management_system/features/manager_reports/data/web_services/manager_report_web_services.dart';

import '../../../../core/utils/result.dart';

class ManagerReportRepo {
  final ManagerReportWebServices _reportWebServices;

  ManagerReportRepo({required ManagerReportWebServices reportWebServices})
    : _reportWebServices = reportWebServices;

  Future<Result<ManagerReportsModel>> getManagerReports({
    final String? startDate,
    final String? endDate,
    final String? status,
  }) async {
    try {
      final result = await _reportWebServices.getManagerReports(
        startDate: startDate,
        endDate: endDate,
        status: status,
      );
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
