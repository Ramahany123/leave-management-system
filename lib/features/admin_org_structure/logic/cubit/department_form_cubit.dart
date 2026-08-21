import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/admin_org_structure/data/repo/admin_org_repo.dart';

part 'department_form_state.dart';

class DepartmentFormCubit extends Cubit<DepartmentFormState> {
  final AdminOrgRepo _orgRepo;

  DepartmentFormCubit({required AdminOrgRepo orgRepo})
    : _orgRepo = orgRepo,
      super(DepartmentFormInitial());

  Future<void> createDepartment({
    required String deptName,
    required int collegeId,
    int? headId,
  }) async {
    emit(DepartmentFormLoading());
    final result = await _orgRepo.createDepartment(
      deptName: deptName,
      collegeId: collegeId,
      headId: headId,
    );
    result.fold(
      (_) {
        emit(DepartmentFormSuccess());
      },
      (failure) {
        emit(DepartmentFormError(failure: failure));
      },
    );
  }

  Future<void> updateDepartment(
    int deptId, {
    String? deptName,
    int? collegeId,
    int? headId,
  }) async {
    emit(DepartmentFormLoading());
    final result = await _orgRepo.updateDepartment(
      deptId,
      deptName: deptName,
      collegeId: collegeId,
      headId: headId,
    );
    result.fold(
      (_) {
        emit(DepartmentFormSuccess());
      },
      (failure) {
        emit(DepartmentFormError(failure: failure));
      },
    );
  }
}
