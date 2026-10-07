import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/repo/leave_type_repo.dart';

import '../../data/models/create_leave_type_request_model.dart';
import '../../data/models/update_leave_type_request_model.dart';

part 'leave_type_form_state.dart';

class LeaveTypeFormCubit extends Cubit<LeaveTypeFormState> {
  final LeaveTypeRepo _repo;
  LeaveTypeFormCubit({required LeaveTypeRepo repo})
    : _repo = repo,
      super(LeaveTypeFormInitial());

  void _safeEmit(LeaveTypeFormState newState) {
    if (!isClosed) emit(newState);
  }

  Future<void> createLeaveType(CreateLeaveTypeRequestModel requestBody) async {
    if (state is LeaveTypeFormLoading) return;
    _safeEmit(LeaveTypeFormLoading());
    final result = await _repo.createLeaveType(requestBody: requestBody);
    if (isClosed) return;
    result.fold(
      (_) {
        _safeEmit(LeaveTypeFormSuccess());
      },
      (failure) {
        _safeEmit(LeaveTypeFormError(failure: failure));
      },
    );
  }

  Future<void> updateLeaveType({
    required int id,
    required UpdateLeaveTypeRequestModel requestBody,
  }) async {
    if (state is LeaveTypeFormLoading) return;
    if (!requestBody.hasChanges) {
      _safeEmit(LeaveTypeFormSuccess());
      return;
    }
    _safeEmit(LeaveTypeFormLoading());
    final result = await _repo.updateLeaveType(id, requestBody: requestBody);
    if (isClosed) return;
    result.fold(
      (_) {
        _safeEmit(LeaveTypeFormSuccess());
      },
      (failure) {
        _safeEmit(LeaveTypeFormError(failure: failure));
      },
    );
  }
}
