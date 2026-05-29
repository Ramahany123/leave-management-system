part of 'update_contact_cubit.dart';

@immutable
sealed class UpdateContactState {}

final class UpdateContactInitial extends UpdateContactState {}

final class UpdateContactLoading extends UpdateContactState {}

final class UpdateContactSuccess extends UpdateContactState {
  final UpdateContactResponseModel updateContactResponse;

  UpdateContactSuccess({required this.updateContactResponse});
}

final class UpdateContactError extends UpdateContactState {
  final Failure failure;

  UpdateContactError({required this.failure});
}
