part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel user;

  ProfileSuccess({required this.user});
}

final class ProfileError extends ProfileState {
  final Failure failure;

  ProfileError({required this.failure});
}
