import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';

class ReportWebService {
  final ApiService _apiService;

  ReportWebService({required ApiService apiService}) : _apiService = apiService;

  Future<ReportResponseModel> getReport({
    String? status,
    int? departmentId,
    int? typeId,
    int? userId,
    String? startDate,
    String? endDate,
    int limit = 10,
    int offset = 0,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'status': status,
      'department_id': departmentId,
      'type_id': typeId,
      'user_id': userId,
      'start_date': startDate,
      'end_date': endDate,
      'limit': limit,
      'offset': offset,
    }..removeWhere((_, value) => value == null);
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminReports,
      queryParameters: queryParameters,
    );
    return ReportResponseModel.fromJson(response.data);
  }

  Future<void> overrideStatus(
    int id, {
    required String status,
    required String comments,
  }) async {
    final Map<String, dynamic> data = {"status": status, "comments": comments};
    await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.adminReport(id),
      data: data,
    );
  }
}
