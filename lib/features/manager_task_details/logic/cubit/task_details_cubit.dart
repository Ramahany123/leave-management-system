import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/manager_task_details/data/models/task_detail_model.dart';
import 'package:leave_management_system/features/manager_task_details/data/repo/task_details_repo.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final TaskDetailsRepo _taskDetailsRepo;
  TaskDetailsCubit({required TaskDetailsRepo taskDetailsRepo})
    : _taskDetailsRepo = taskDetailsRepo,
      super(TaskDetailsInitial());

  Future<void> getTaskDetails(int stepId) async {
    emit(TaskDetailsLoading());
    final result = await _taskDetailsRepo.getTaskDetails(stepId);
    result.fold(
      (taskDetails) {
        emit(TaskDetailsSuccess(taskDetails: taskDetails));
      },
      (failure) {
        emit(TaskDetailsError(failure: failure));
      },
    );
  }
}
