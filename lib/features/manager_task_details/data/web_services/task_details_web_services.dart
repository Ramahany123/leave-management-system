import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/manager_task_details/data/models/task_detail_model.dart';

class TaskDetailsWebServices {
  final ApiService _apiService;

  TaskDetailsWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<TaskDetailsModel> getTaskDetails(int stepId) async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getApprovalTaskDetails(stepId),
    );
    return TaskDetailsModel.fromJson(response.data);
  }

  Future<void> approveTask(
    int stepId, {
    String? comments,
    String? sessionNumber,
    DateTime? sessionDate,
  }) async {
    final Map<String, String?> body = {
      "comments": comments,
      "session_number": sessionNumber,
      "session_date": sessionDate?.toIso8601String().split("T").first,
    };
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.approveTask(stepId),
      data: body,
    );
  }

  Future<void> rejectTask(int stepId, String reason) async {
    final Map<String, String> body = {"reason": reason};
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.rejectTask(stepId),
      data: body,
    );
  }
}
