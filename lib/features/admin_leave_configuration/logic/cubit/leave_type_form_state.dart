part of 'leave_type_form_cubit.dart';

@immutable
sealed class LeaveTypeFormState {}

final class LeaveTypeFormInitial extends LeaveTypeFormState {}

final class LeaveTypeFormLoading extends LeaveTypeFormState {}

final class LeaveTypeFormSuccess extends LeaveTypeFormState {}

final class LeaveTypeFormError extends LeaveTypeFormState {
  final Failure failure;

  LeaveTypeFormError({required this.failure});
}
