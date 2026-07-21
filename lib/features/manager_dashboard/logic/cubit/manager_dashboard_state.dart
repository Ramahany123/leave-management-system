part of 'manager_dashboard_cubit.dart';

@immutable
sealed class ManagerDashboardState {}

final class ManagerDashboardLoading extends ManagerDashboardState {}

final class ManagerDashboardSuccess extends ManagerDashboardState {
  final ManagerDashboardModel managerDashboardModel;

  ManagerDashboardSuccess({required this.managerDashboardModel});
}

final class ManagerDashboardError extends ManagerDashboardState {
  final Failure failure;

  ManagerDashboardError({required this.failure});
}
