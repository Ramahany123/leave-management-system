part of 'leave_history_cubit.dart';

@immutable
sealed class LeaveHistoryState {}

final class LeaveHistoryLoading extends LeaveHistoryState {}

final class LeaveHistorySuccess extends LeaveHistoryState {
  final List<LeaveRequestModel> leaveHistoryRequests;
  final String selectedStatus;

  LeaveHistorySuccess({
    required this.leaveHistoryRequests,
    this.selectedStatus = RequestStatus.all,
  });
}

final class LeaveHistoryError extends LeaveHistoryState {
  final Failure failure;

  LeaveHistoryError({required this.failure});
}
