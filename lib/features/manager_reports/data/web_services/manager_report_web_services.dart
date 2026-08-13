import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/manager_reports/data/models/manager_reports_model.dart';

class ManagerReportWebServices {
  final ApiService _apiService;

  ManagerReportWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<ManagerReportsModel> getManagerReports({
    final String? startDate,
    final String? endDate,
    final String? status,
  }) async {
    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
      "status": status,
    };
    queryParameters.removeWhere(
      (key, value) => value == null || (value is String && value.isEmpty),
    );
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getManagerReport,
      queryParameters: queryParameters,
    );
    return ManagerReportsModel.fromJson(response.data);
  }
}
