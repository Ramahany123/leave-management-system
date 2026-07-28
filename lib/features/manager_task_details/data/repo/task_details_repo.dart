import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/core/utils/result.dart';
import 'package:leave_management_system/features/manager_task_details/data/models/task_detail_model.dart';
import 'package:leave_management_system/features/manager_task_details/data/web_services/task_details_web_services.dart';

class TaskDetailsRepo {
  final TaskDetailsWebServices _taskDetailsWebServices;

  TaskDetailsRepo({required TaskDetailsWebServices taskDetailsWebServices})
    : _taskDetailsWebServices = taskDetailsWebServices;

  Future<Result<TaskDetailsModel>> getTaskDetails(int stepId) async {
    try {
      final result = await _taskDetailsWebServices.getTaskDetails(stepId);
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> approveTask(
    int stepId, {
    String? comments,
    String? sessionNumber,
    DateTime? sessionDate,
  }) async {
    try {
      final result = await _taskDetailsWebServices.approveTask(
        stepId,
        comments: comments,
        sessionNumber: sessionNumber,
        sessionDate: sessionDate,
      );
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> rejectTask(int stepId, String reason) async {
    try {
      final result = await _taskDetailsWebServices.rejectTask(stepId, reason);
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
