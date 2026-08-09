part of 'manager_report_cubit.dart';

@immutable
sealed class ManagerReportState {}

final class ManagerReportLoading extends ManagerReportState {}

final class ManagerReportSuccess extends ManagerReportState {
  final ManagerReportsModel managerReportsModel;
  final List<ReportRecord> filteredReports;
  final String? selectedStatus;
  final DateTimeRange? selectedRange;

  ManagerReportSuccess({
    required this.managerReportsModel,
    required this.filteredReports,
    required this.selectedStatus,
    required this.selectedRange,
  });
}

final class ManagerReportError extends ManagerReportState {
  final Failure failure;

  ManagerReportError({required this.failure});
}
