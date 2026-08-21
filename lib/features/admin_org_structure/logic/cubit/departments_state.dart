part of 'departments_cubit.dart';

@immutable
sealed class DepartmentsState {}

final class DepartmentsInitial extends DepartmentsState {}

final class DepartmentsLoading extends DepartmentsState {}

final class DepartmentsSuccess extends DepartmentsState {
  final List<Department> departments;
  final int? collegeId;

  DepartmentsSuccess({required this.departments, this.collegeId});
}

final class DepartmentsError extends DepartmentsState {
  final Failure failure;

  DepartmentsError({required this.failure});
}
