part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess({required this.message});
}

final class ChangePasswordError extends ChangePasswordState {
  final Failure failure;

  ChangePasswordError({required this.failure});
}
