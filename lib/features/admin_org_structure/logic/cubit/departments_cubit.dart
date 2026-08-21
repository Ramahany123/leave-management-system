import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';

import '../../data/models/all_departements_model.dart';
import '../../data/repo/admin_org_repo.dart';

part 'departments_state.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  final AdminOrgRepo _orgRepo;
  List<Department> _allDepartments = [];
  String _searchQuery = "";
  int? _selectedCollegeId;
  int? get selectedCollegeId => _selectedCollegeId;

  DepartmentsCubit({required AdminOrgRepo orgRepo})
    : _orgRepo = orgRepo,
      super(DepartmentsInitial());

  Future<void> getAllDepartments() async {
    emit(DepartmentsLoading());
    final result = await _orgRepo.getAllDepartments(
      collegeId: _selectedCollegeId,
    );
    result.fold(
      (departmentResponse) {
        _allDepartments = departmentResponse.allDepartments;
        _applyLocalFiltersAndEmit();
      },
      (failure) {
        emit(DepartmentsError(failure: failure));
      },
    );
  }

  Future<void> filterbyCollegeId(int? collegeId) async {
    _selectedCollegeId = collegeId;
    await getAllDepartments();
  }

  Future<void> deleteDepartment(int deptId) async {
    emit(DepartmentsLoading());
    final result = await _orgRepo.deleteDepartment(deptId);
    result.fold(
      (departmentResponse) {
        _allDepartments.removeWhere((dept) => dept.departmentId == deptId);
        _applyLocalFiltersAndEmit();
      },
      (failure) {
        emit(DepartmentsError(failure: failure));
      },
    );
  }

  void searchDepartments(String query) {
    if (_allDepartments.isEmpty) return;
    _searchQuery = query;
    _applyLocalFiltersAndEmit();
  }

  void _applyLocalFiltersAndEmit() {
    var filteredList = _allDepartments;
    if (_searchQuery.isNotEmpty) {
      final exp = RegExp(RegExp.escape(_searchQuery), caseSensitive: false);
      filteredList = filteredList.where((dept) {
        final hasDeptName = exp.hasMatch(dept.departmentName);
        final hasDeptHeadName = dept.head == null
            ? false
            : exp.hasMatch(dept.head!.name);
        return hasDeptName || hasDeptHeadName;
      }).toList();
    }
    emit(
      DepartmentsSuccess(
        departments: filteredList,
        collegeId: _selectedCollegeId,
      ),
    );
  }
}
