part of 'department_form_cubit.dart';

@immutable
sealed class DepartmentFormState {}

final class DepartmentFormInitial extends DepartmentFormState {}

final class DepartmentFormLoading extends DepartmentFormState {}

final class DepartmentFormSuccess extends DepartmentFormState {}

final class DepartmentFormError extends DepartmentFormState {
  final Failure failure;

  DepartmentFormError({required this.failure});
}
