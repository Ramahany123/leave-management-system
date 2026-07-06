part of 'leave_request_details_cubit.dart';

@immutable
sealed class LeaveRequestDetailsState {}

final class LeaveRequestDetailsInitial extends LeaveRequestDetailsState {}

final class LeaveRequestDetailsLoading extends LeaveRequestDetailsState {}

final class LeaveRequestDetailsSuccess extends LeaveRequestDetailsState {
  final LeaveRequestDetailsModel leaveRequestDetails;

  LeaveRequestDetailsSuccess({required this.leaveRequestDetails});
}

final class LeaveRequestDetailsError extends LeaveRequestDetailsState {
  final Failure failure;

  LeaveRequestDetailsError({required this.failure});
}
