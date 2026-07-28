import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';

import '../../data/repo/task_details_repo.dart';

part 'task_approval_action_state.dart';

class TaskApprovalActionCubit extends Cubit<TaskApprovalActionState> {
  final TaskDetailsRepo _detailsRepo;
  TaskApprovalActionCubit({required TaskDetailsRepo detailsRepo})
    : _detailsRepo = detailsRepo,
      super(TaskApprovalActionInitial());

  Future<void> approveTask(
    int stepId, {
    String? comments,
    String? sessionNumber,
    DateTime? sessionDate,
  }) async {
    emit(TaskApprovalLoading());
    final result = await _detailsRepo.approveTask(
      stepId,
      comments: comments,
      sessionNumber: sessionNumber,
      sessionDate: sessionDate,
    );
    result.fold(
      (_) {
        emit(TaskApprovalSuccess(isApproved: true));
      },
      (failure) {
        emit(TaskApprovalError(failure: failure));
      },
    );
  }

  Future<void> rejectTask(int stepId, String reason) async {
    emit(TaskApprovalLoading());
    final result = await _detailsRepo.rejectTask(stepId, reason);
    result.fold(
      (_) {
        emit(TaskApprovalSuccess(isApproved: false));
      },
      (failure) {
        emit(TaskApprovalError(failure: failure));
      },
    );
  }
}
