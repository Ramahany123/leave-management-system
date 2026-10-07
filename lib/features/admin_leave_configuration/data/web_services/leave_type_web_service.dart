import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/create_leave_type_request_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/update_leave_type_request_model.dart';

class LeaveTypeWebService {
  final ApiService _apiService;

  LeaveTypeWebService({required ApiService apiService})
    : _apiService = apiService;

  Future<LeaveTypeList> getLeaveTypes() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminLeaveTypes,
    );
    return LeaveTypeList.fromJson(response.data);
  }

  Future<void> createLeaveType({
    required CreateLeaveTypeRequestModel requestBody,
  }) async {
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.adminLeaveTypes,
      data: requestBody.toJson(),
    );
  }

  Future<void> updateLeaveType(
    int id, {
    required UpdateLeaveTypeRequestModel requestBody,
  }) async {
    await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.adminLeaveType(id),
      data: requestBody.toJson(),
    );
  }

  Future<void> deleteLeaveType(int id) async {
    await _apiService.deleteRequest(
      apiEndpoint: ApiEndpoints.adminLeaveType(id),
    );
  }
}
