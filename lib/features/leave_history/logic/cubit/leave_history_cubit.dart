import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/leave_history/data/repo/leave_history_repo.dart';

import '../../../../core/models/leave_request_model.dart';

part 'leave_history_state.dart';

class LeaveHistoryCubit extends Cubit<LeaveHistoryState> {
  final LeaveHistoryRepo _leaveHistoryRepo;
  List<LeaveRequestModel> _allRequests = [];
  String _currentFilter = RequestStatus.all;
  LeaveHistoryCubit({required LeaveHistoryRepo leaveHistoryRepo})
    : _leaveHistoryRepo = leaveHistoryRepo,
      super(LeaveHistoryLoading());

  Future<void> getLeaveHistory() async {
    emit(LeaveHistoryLoading());
    final result = await _leaveHistoryRepo.getLeaveHistory();
    result.fold(
      (final leaveHistoryResponse) {
        _allRequests = leaveHistoryResponse.leaveRequests;
        filterLeaveRequests(_currentFilter);
      },
      (final failure) {
        emit(LeaveHistoryError(failure: failure));
      },
    );
  }

  void filterLeaveRequests(String status) {
    _currentFilter = status;
    final List<LeaveRequestModel> filteredData;
    if (status == RequestStatus.all) {
      filteredData = _allRequests;
    } else {
      filteredData = _allRequests.where((req) => req.status == status).toList();
    }
    emit(
      LeaveHistorySuccess(
        leaveHistoryRequests: filteredData,
        selectedStatus: status,
      ),
    );
  }
}
