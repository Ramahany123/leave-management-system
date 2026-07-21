import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/manager_dashboard/data/models/manager_dashboard_model.dart';
import 'package:leave_management_system/features/manager_dashboard/data/web_services/manager_dashboard_web_services.dart';

class ManagerDashboardRepo {
  final ManagerDashboardWebServices _dashboardWebServices;

  ManagerDashboardRepo({
    required ManagerDashboardWebServices dashboardWebServices,
  }) : _dashboardWebServices = dashboardWebServices;

  Future<Result<ManagerDashboardModel>> getManagerDashboard() async {
    try {
      final response = await _dashboardWebServices.getManagerDashboard();
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
