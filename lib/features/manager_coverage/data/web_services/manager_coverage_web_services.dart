import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/manager_coverage/data/models/team_on_leave_model.dart';

class ManagerCoverageWebServices {
  final ApiService _apiService;

  ManagerCoverageWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<TeamOnLeaveModel> getTeamOnLeave({String? date}) async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getMembersOnLeave,
      queryParameters: date != null ? {'date': date} : null,
    );
    return TeamOnLeaveModel.fromJson(response.data);
  }
}
