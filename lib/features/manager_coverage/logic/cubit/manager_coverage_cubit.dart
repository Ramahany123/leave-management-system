import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/features/manager_coverage/data/models/team_on_leave_model.dart';
import 'package:leave_management_system/features/manager_coverage/data/repo/manager_coverage_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'manager_coverage_state.dart';

class ManagerCoverageCubit extends Cubit<ManagerCoverageState> {
  final ManagerCoverageRepo _coverageRepo;
  String _searchQuery = "";
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  List<TeamMemberOnLeave> _allEmployeeList = [];
  TeamOnLeaveModel? _currentTeamOnLeaveModel;

  ManagerCoverageCubit({required ManagerCoverageRepo coverageRepo})
    : _coverageRepo = coverageRepo,
      super(ManagerCoverageLoading());

  Future<void> getTeamOnLeave({DateTime? targetDate}) async {
    emit(ManagerCoverageLoading());
    _selectedDate = targetDate ?? _selectedDate;
    final result = await _coverageRepo.getTeamOnLeave(
      date: _selectedDate.toApiDate,
    );
    result.fold(
      (teamOnLeave) {
        _allEmployeeList = teamOnLeave.employees;
        _currentTeamOnLeaveModel = teamOnLeave;
        _applyFiltersAndEmit();
      },
      (failure) {
        emit(ManagerCoverageError(failure: failure));
      },
    );
  }

  void searchTeamMembers(String query) {
    if (_currentTeamOnLeaveModel == null) return;
    _searchQuery = query;
    _applyFiltersAndEmit();
  }

  void _applyFiltersAndEmit() {
    var filteredList = _allEmployeeList;
    if (_searchQuery.isNotEmpty) {
      final exp = RegExp(RegExp.escape(_searchQuery), caseSensitive: false);
      filteredList = filteredList.where((member) {
        final nameMatch = exp.hasMatch(member.employeeName);
        final deptMatch = exp.hasMatch(member.department);
        return nameMatch || deptMatch;
      }).toList();
    }
    emit(
      ManagerCoverageSuccess(
        teamOnLeave: _currentTeamOnLeaveModel!,
        filteredEmployees: filteredList,
        selectedDate: _selectedDate,
      ),
    );
  }
}
