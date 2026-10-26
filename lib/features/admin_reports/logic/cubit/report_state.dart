part of 'report_cubit.dart';

const Object _unset = Object();

@immutable
final class ReportState {
  final List<ReportLeaveRequest> requests;
  final int total;
  final ReportQuery query;
  final bool isInitialLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final Failure? initialFailure;
  final Failure? refreshFailure;
  final Failure? loadMoreFailure;

  ReportState({
    List<ReportLeaveRequest> requests = const [],
    this.total = 0,
    this.query = const ReportQuery(),
    this.isInitialLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.initialFailure,
    this.refreshFailure,
    this.loadMoreFailure,
  }) : requests = List.unmodifiable(requests);

  ReportState copyWith({
    List<ReportLeaveRequest>? requests,
    int? total,
    ReportQuery? query,
    bool? isInitialLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    Object? initialFailure = _unset,
    Object? refreshFailure = _unset,
    Object? loadMoreFailure = _unset,
  }) {
    return ReportState(
      requests: requests ?? this.requests,
      total: total ?? this.total,
      query: query ?? this.query,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      initialFailure: initialFailure != _unset
          ? initialFailure as Failure?
          : this.initialFailure,
      refreshFailure: refreshFailure != _unset
          ? refreshFailure as Failure?
          : this.refreshFailure,
      loadMoreFailure: loadMoreFailure != _unset
          ? loadMoreFailure as Failure?
          : this.loadMoreFailure,
    );
  }
}
