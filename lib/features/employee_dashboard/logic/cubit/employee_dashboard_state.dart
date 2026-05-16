part of 'employee_dashboard_cubit.dart';

@immutable
sealed class EmployeeDashboardState {}

final class EmployeeDashboardLoading extends EmployeeDashboardState {}

final class EmployeeDashboardSuccess extends EmployeeDashboardState {
  final EmployeeDashboardResponseModel employeeDashboardResponse;

  EmployeeDashboardSuccess({required this.employeeDashboardResponse});
}

final class EmployeeDashboardError extends EmployeeDashboardState {
  final Failure failure;

  EmployeeDashboardError({required this.failure});
}
