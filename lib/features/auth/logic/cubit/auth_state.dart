part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated({required this.user});
}

final class AuthNeedActivation extends AuthState {
  final UserModel user;

  AuthNeedActivation({required this.user});
}

final class AuthError extends AuthState {
  final Failure failure;

  AuthError({required this.failure});
}
