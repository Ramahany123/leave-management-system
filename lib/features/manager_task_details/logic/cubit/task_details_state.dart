part of 'task_details_cubit.dart';

@immutable
sealed class TaskDetailsState {}

final class TaskDetailsInitial extends TaskDetailsState {}

final class TaskDetailsLoading extends TaskDetailsState {}

final class TaskDetailsSuccess extends TaskDetailsState {
  final TaskDetailsModel taskDetails;

  TaskDetailsSuccess({required this.taskDetails});
}

final class TaskDetailsError extends TaskDetailsState {
  final Failure failure;

  TaskDetailsError({required this.failure});
}
