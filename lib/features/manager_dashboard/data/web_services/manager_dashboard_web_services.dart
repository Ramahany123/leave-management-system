import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/manager_dashboard/data/models/manager_dashboard_model.dart';

class ManagerDashboardWebServices {
  final ApiService _apiService;

  ManagerDashboardWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<ManagerDashboardModel> getManagerDashboard() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getManagerDashboard,
    );
    return ManagerDashboardModel.fromJson(response.data);
  }
}
