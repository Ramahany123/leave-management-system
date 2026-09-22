part of 'admin_user_form_cubit.dart';

@immutable
sealed class AdminUserFormState {}

final class AdminUserFormInitial extends AdminUserFormState {}

final class AdminUserFormLoading extends AdminUserFormState {}

final class AdminUserFormSuccess extends AdminUserFormState {}

final class AdminUserFormError extends AdminUserFormState {
  final Failure failure;

  AdminUserFormError({required this.failure});
}
