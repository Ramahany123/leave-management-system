part of 'override_report_cubit.dart';

@immutable
sealed class OverrideReportState {}

final class OverrideReportInitial extends OverrideReportState {}

final class OverrideReportLoading extends OverrideReportState {}

final class OverrideReportSuccess extends OverrideReportState {}

final class OverrideReportError extends OverrideReportState {
  final Failure failure;

  OverrideReportError({required this.failure});
}
