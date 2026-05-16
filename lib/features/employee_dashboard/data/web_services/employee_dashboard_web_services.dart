import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/employee_dashboard_response_model.dart';

class EmployeeDashboardWebServices {
  final ApiService _apiService;

  EmployeeDashboardWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<EmployeeDashboardResponseModel> getEmployeeDashboard() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.employeeDashboard,
    );
    return EmployeeDashboardResponseModel.fromJson(response.data);
  }
}
