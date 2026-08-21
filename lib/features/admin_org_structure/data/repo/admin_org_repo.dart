import 'package:leave_management_system/core/networking/api_error_handler.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/data/web_service/admin_org_web_services.dart';

import '../../../../core/utils/result.dart';
import '../models/all_departements_model.dart';

class AdminOrgRepo {
  final AdminOrgWebServices _orgWebServices;

  AdminOrgRepo({required AdminOrgWebServices orgWebServices})
    : _orgWebServices = orgWebServices;

  // ==================== COLLEGES ====================
  Future<Result<AllCollegesModel>> getAllColleges() async {
    try {
      final result = await _orgWebServices.getAllColleges();
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<CollegeModel>> getCollege(int collegeId) async {
    try {
      final result = await _orgWebServices.getCollege(collegeId);
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> updateCollege(
    int collegeId, {
    String? name,
    int? deanId,
  }) async {
    try {
      await _orgWebServices.updateCollege(
        collegeId,
        name: name,
        deanId: deanId,
      );
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> createCollege(String collegeName, {int? deanId}) async {
    try {
      await _orgWebServices.createCollege(name: collegeName, deanId: deanId);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> deleteCollege(int collegeId) async {
    try {
      await _orgWebServices.deleteCollege(collegeId);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  // ==================== DEPARTMENTS ====================
  Future<Result<DepartmentResponse>> getAllDepartments({int? collegeId}) async {
    try {
      final result = await _orgWebServices.getAllDepartments(
        collegeId: collegeId,
      );
      return SuccessResult(result);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> createDepartment({
    required String deptName,
    required int collegeId,
    int? headId,
  }) async {
    try {
      await _orgWebServices.createDepartment(
        deptName: deptName,
        collegeId: collegeId,
        headId: headId,
      );
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> updateDepartment(
    int deptId, {
    String? deptName,
    int? collegeId,
    int? headId,
  }) async {
    try {
      await _orgWebServices.updateDepartment(
        deptId,
        deptName: deptName,
        collegeId: collegeId,
        headId: headId,
      );
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }

  Future<Result<void>> deleteDepartment(int deptId) async {
    try {
      await _orgWebServices.deleteDepartment(deptId);
      return SuccessResult(null);
    } catch (e) {
      return FailureResult(ApiErrorHandler.handle(e));
    }
  }
}
