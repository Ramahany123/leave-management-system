import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/leave_history/data/models/leave_history_model.dart';

class LeaveHistoryWebServices {
  final ApiService _apiService;

  LeaveHistoryWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<LeaveHistoryModel> getLeaveHistory() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getLeaveRequestsHistory,
    );
    return LeaveHistoryModel.fromJson(response.data);
  }
}
