part of 'leave_request_cubit.dart';

@immutable
sealed class LeaveRequestState {}

final class LeaveRequestInitial extends LeaveRequestState {}

final class LeaveRequestFormLoading extends LeaveRequestState {}

final class LeaveRequestFormSuccess extends LeaveRequestState {
  final List<DelegateUserModel> delegateUsers;
  final List<EligibleLeaveTypeModel> eligibleLeaveTypes;
  final LeaveRequestFormFields formFields;

  LeaveRequestFormSuccess({
    required this.delegateUsers,
    required this.eligibleLeaveTypes,
    required this.formFields,
  });
}

final class LeaveRequestFormError extends LeaveRequestState {
  final Failure failure;

  LeaveRequestFormError({required this.failure});
}

final class LeaveRequestSubmitLoading extends LeaveRequestFormSuccess {
  LeaveRequestSubmitLoading({
    required super.delegateUsers,
    required super.eligibleLeaveTypes,
    required super.formFields,
  });
}

final class LeaveRequestSubmitSuccess extends LeaveRequestState {
  final CreateLeaveRequestResponseModel createLeaveRequestResponse;

  LeaveRequestSubmitSuccess({required this.createLeaveRequestResponse});
}

final class LeaveRequestSubmitError extends LeaveRequestFormSuccess {
  final Failure failure;

  LeaveRequestSubmitError({
    required this.failure,
    required super.delegateUsers,
    required super.eligibleLeaveTypes,
    required super.formFields,
  });
}
