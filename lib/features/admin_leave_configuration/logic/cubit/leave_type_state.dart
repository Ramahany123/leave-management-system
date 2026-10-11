part of 'leave_type_cubit.dart';

@immutable
final class LeaveTypeState {
  final List<LeaveType> leaveTypesList;
  final InitialLoadingStatus initialLoadingStatus;
  final bool isRefreshing;
  final Failure? refreshFailure;
  final Failure? getLeaveTypeFailure;
  final Failure? deleteLeaveTypeFailure;
  final int? deletingLeaveId;
  final String searchQuery;

  const LeaveTypeState({
    this.leaveTypesList = const [],
    this.getLeaveTypeFailure,
    this.deleteLeaveTypeFailure,
    this.deletingLeaveId,
    this.searchQuery = "",
    this.initialLoadingStatus = InitialLoadingStatus.initial,
    this.isRefreshing = false,
    this.refreshFailure,
  });

  static const _unset = Object();

  LeaveTypeState copyWith({
    Object? getLeaveTypeFailure = _unset,
    List<LeaveType>? leaveTypesList,
    InitialLoadingStatus? initialLoadingStatus,
    bool? isRefreshing,
    Object? refreshFailure = _unset,
    Object? deleteLeaveTypeFailure = _unset,
    Object? deletingLeaveId = _unset,
    String? searchQuery,
  }) {
    return LeaveTypeState(
      getLeaveTypeFailure: getLeaveTypeFailure == _unset
          ? this.getLeaveTypeFailure
          : getLeaveTypeFailure as Failure?,
      leaveTypesList: leaveTypesList ?? this.leaveTypesList,
      initialLoadingStatus: initialLoadingStatus ?? this.initialLoadingStatus,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      refreshFailure: refreshFailure == _unset
          ? this.refreshFailure
          : refreshFailure as Failure?,
      deleteLeaveTypeFailure: deleteLeaveTypeFailure == _unset
          ? this.deleteLeaveTypeFailure
          : deleteLeaveTypeFailure as Failure?,
      deletingLeaveId: deletingLeaveId == _unset
          ? this.deletingLeaveId
          : deletingLeaveId as int?,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
