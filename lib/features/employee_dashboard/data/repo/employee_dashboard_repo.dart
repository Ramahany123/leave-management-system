import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/employee_dashboard_response_model.dart';
import 'package:leave_management_system/features/employee_dashboard/data/web_services/employee_dashboard_web_services.dart';

class EmployeeDashboardRepo {
  final EmployeeDashboardWebServices _employeeDashboardWebServices;

  EmployeeDashboardRepo({
    required EmployeeDashboardWebServices employeeDashboardWebServices,
  }) : _employeeDashboardWebServices = employeeDashboardWebServices;

  Future<Result<EmployeeDashboardResponseModel>> getEmployeeDashboard() async {
    try {
      final response = await _employeeDashboardWebServices
          .getEmployeeDashboard();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
