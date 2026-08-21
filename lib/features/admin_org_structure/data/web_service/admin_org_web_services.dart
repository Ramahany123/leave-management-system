import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_departements_model.dart';

class AdminOrgWebServices {
  final ApiService _apiService;

  AdminOrgWebServices({required ApiService apiService})
    : _apiService = apiService;

  // ==================== COLLEGES ====================
  Future<AllCollegesModel> getAllColleges() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminColleges,
    );
    return AllCollegesModel.fromJson(response.data);
  }

  Future<void> createCollege({required String name, int? deanId}) async {
    Map<String, dynamic> body = {
      "college_name": name,
      if (deanId != null) "dean_user_id": deanId,
    };
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.adminColleges,
      data: body,
    );
  }

  Future<CollegeModel> getCollege(int collegeId) async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminCollege(collegeId),
    );
    return CollegeModel.fromJson(response.data);
  }

  Future<void> updateCollege(int collegeId, {String? name, int? deanId}) async {
    Map<String, dynamic> body = {
      if (name != null && name.isNotEmpty) "college_name": name,
      if (deanId != null) "dean_user_id": deanId,
    };
    await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.adminCollege(collegeId),
      data: body,
    );
  }

  Future<void> deleteCollege(int collegeId) async {
    await _apiService.deleteRequest(
      apiEndpoint: ApiEndpoints.adminCollege(collegeId),
    );
  }

  // ==================== DEPARTMENTS ====================
  Future<DepartmentResponse> getAllDepartments({int? collegeId}) async {
    final Map<String, dynamic> queryParam = {
      if (collegeId != null) "college_id": collegeId,
    };
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminDepartments,
      queryParameters: queryParam,
    );
    return DepartmentResponse.fromJson(response.data);
  }

  Future<void> createDepartment({
    required String deptName,
    required int collegeId,
    int? headId,
  }) async {
    final Map<String, dynamic> body = {
      "department_name": deptName,
      "college_id": collegeId,
      if (headId != null) "head_user_id": headId,
    };
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.adminDepartments,
      data: body,
    );
  }

  Future<void> updateDepartment(
    int deptId, {
    String? deptName,
    int? collegeId,
    int? headId,
  }) async {
    final Map<String, dynamic> body = {
      if (deptName != null && deptName.isNotEmpty) "department_name": deptName,
      if (collegeId != null) "college_id": collegeId,
      if (headId != null) "head_user_id": headId,
    };
    await _apiService.putRequest(
      apiEndpoint: ApiEndpoints.adminDepartment(deptId),
      data: body,
    );
  }

  Future<void> deleteDepartment(int deptId) async {
    await _apiService.deleteRequest(
      apiEndpoint: ApiEndpoints.adminDepartment(deptId),
    );
  }
}
