part of 'college_form_cubit.dart';

@immutable
sealed class CollegeFormState {}

final class CollegeFormInitial extends CollegeFormState {}

final class CollegeFormLoading extends CollegeFormState {}

final class CollegeFormSuccess extends CollegeFormState {}

final class CollegeFormError extends CollegeFormState {
  final Failure failure;

  CollegeFormError({required this.failure});
}
