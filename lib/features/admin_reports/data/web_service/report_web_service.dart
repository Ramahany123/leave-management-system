import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_query.dart';

class ReportWebService {
  final ApiService _apiService;

  ReportWebService({required ApiService apiService}) : _apiService = apiService;

  Future<ReportResponseModel> getReport(ReportQuery query) async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminReports,
      queryParameters: query.toQueryParameters(),
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
