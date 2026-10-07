import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/repo/leave_type_repo.dart';

import '../../../../core/networking/errors/failures.dart';
import '../../../../core/utils/result.dart';

part 'leave_type_state.dart';

class LeaveTypeCubit extends Cubit<LeaveTypeState> {
  final LeaveTypeRepo _repo;
  List<LeaveType> _allLeaveTypes = [];

  LeaveTypeCubit({required LeaveTypeRepo repo})
    : _repo = repo,
      super(LeaveTypeState());

  void _safeEmit(LeaveTypeState newState) {
    if (!isClosed) emit(newState);
  }

  Future<Result<LeaveTypeList>?> _fetch() async {
    if (state.deletingLeaveId != null) return null;
    final result = await _repo.getLeaveTypes();
    if (isClosed) return null;
    return result;
  }

  List<LeaveType> _filterLeaveTypes(String query) {
    if (query.isEmpty) return List<LeaveType>.from(_allLeaveTypes);
    final regExp = RegExp(RegExp.escape(query), caseSensitive: false);
    return _allLeaveTypes
        .where((item) => regExp.hasMatch(item.typeName))
        .toList();
  }

  List<LeaveType> _updateLeaveTypes(LeaveTypeList leaveTypeList) {
    _allLeaveTypes = List<LeaveType>.from(leaveTypeList.list);
    return _filterLeaveTypes(state.searchQuery);
  }

  Future<void> getLeaveTypes() async {
    if (state.initialLoadingStatus == InitialLoadingStatus.loading) return;
    _safeEmit(
      state.copyWith(
        initialLoadingStatus: InitialLoadingStatus.loading,
        getLeaveTypeFailure: null,
      ),
    );

    final result = await _fetch();
    if (result == null) return;

    result.fold(
      (leaveTypeList) {
        _safeEmit(
          state.copyWith(
            initialLoadingStatus: InitialLoadingStatus.success,
            leaveTypesList: _updateLeaveTypes(leaveTypeList),
          ),
        );
      },
      (failure) {
        _safeEmit(
          state.copyWith(
            initialLoadingStatus: InitialLoadingStatus.failure,
            getLeaveTypeFailure: failure,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.isRefreshing || state.deletingLeaveId != null) return;
    _safeEmit(state.copyWith(isRefreshing: true, refreshFailure: null));

    final result = await _fetch();
    if (result == null) return;

    result.fold(
      (leaveTypeList) {
        _safeEmit(
          state.copyWith(
            isRefreshing: false,
            leaveTypesList: _updateLeaveTypes(leaveTypeList),
          ),
        );
      },
      (failure) {
        _safeEmit(state.copyWith(isRefreshing: false, refreshFailure: failure));
      },
    );
  }

  Future<void> deleteLeaveType(int id) async {
    if (state.isRefreshing || state.deletingLeaveId != null) return;
    _safeEmit(
      state.copyWith(deletingLeaveId: id, deleteLeaveTypeFailure: null),
    );

    final result = await _repo.deleteLeaveType(id);
    if (isClosed) return;

    result.fold(
      (_) {
        _allLeaveTypes.removeWhere((element) => element.typeId == id);
        _safeEmit(
          state.copyWith(
            deletingLeaveId: null,
            leaveTypesList: _filterLeaveTypes(state.searchQuery),
          ),
        );
      },
      (failure) {
        _safeEmit(
          state.copyWith(
            deletingLeaveId: null,
            deleteLeaveTypeFailure: failure,
          ),
        );
      },
    );
  }

  void search(String query) {
    _safeEmit(
      state.copyWith(
        searchQuery: query,
        leaveTypesList: _filterLeaveTypes(query),
      ),
    );
  }
}
