part of 'task_approval_action_cubit.dart';

@immutable
sealed class TaskApprovalActionState {}

final class TaskApprovalActionInitial extends TaskApprovalActionState {}

final class TaskApprovalLoading extends TaskApprovalActionState {}

final class TaskApprovalSuccess extends TaskApprovalActionState {
  final bool isApproved;

  TaskApprovalSuccess({required this.isApproved});
}

final class TaskApprovalError extends TaskApprovalActionState {
  final Failure failure;

  TaskApprovalError({required this.failure});
}
