part of 'manager_coverage_cubit.dart';

@immutable
sealed class ManagerCoverageState {}

final class ManagerCoverageLoading extends ManagerCoverageState {}

final class ManagerCoverageSuccess extends ManagerCoverageState {
  final TeamOnLeaveModel teamOnLeave;
  final List<TeamMemberOnLeave> filteredEmployees;
  final DateTime selectedDate;

  ManagerCoverageSuccess({
    required this.teamOnLeave,
    required this.filteredEmployees,
    required this.selectedDate,
  });
}

final class ManagerCoverageError extends ManagerCoverageState {
  final Failure failure;

  ManagerCoverageError({required this.failure});
}
