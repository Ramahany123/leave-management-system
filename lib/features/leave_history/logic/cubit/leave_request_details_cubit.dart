import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/models/leave_request_details_model.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/leave_history/data/repo/leave_history_repo.dart';

part 'leave_request_details_state.dart';

class LeaveRequestDetailsCubit extends Cubit<LeaveRequestDetailsState> {
  final LeaveHistoryRepo _leaveHistoryRepo;
  LeaveRequestDetailsCubit({required LeaveHistoryRepo leaveHistoryRepo})
    : _leaveHistoryRepo = leaveHistoryRepo,
      super(LeaveRequestDetailsInitial());

  Future<void> getLeaveRequestDetails(int id) async {
    emit(LeaveRequestDetailsLoading());
    final result = await _leaveHistoryRepo.getLeaveRequestDetails(id);
    result.fold(
      (leaveRequestDetails) {
        emit(
          LeaveRequestDetailsSuccess(leaveRequestDetails: leaveRequestDetails),
        );
      },
      (failure) {
        emit(LeaveRequestDetailsError(failure: failure));
      },
    );
  }
}
