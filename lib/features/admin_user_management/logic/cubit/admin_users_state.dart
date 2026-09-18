part of 'admin_users_cubit.dart';

enum UsersStatus {
  initial,
  loading,
  refreshing,
  success,
  failure,
  refreshFailure,
}

@immutable
class AdminUsersState {
  final List<AdminUserModel> users;
  final UsersStatus usersStatus;
  final Failure? deleteUserFailure;
  final int? deletingUserId;
  final String searchQuery;
  final Failure? getAllUsersFailure;

  const AdminUsersState({
    this.users = const [],
    this.usersStatus = UsersStatus.initial,
    this.deleteUserFailure,
    this.deletingUserId,
    this.searchQuery = "",
    this.getAllUsersFailure,
  });

  AdminUsersState copyWith({
    List<AdminUserModel>? users,
    UsersStatus? usersStatus,
    Failure? deleteUserFailure,
    bool clearDeleteUserFailure = false,
    int? deletingUserId,
    bool clearDeletingUserId = false,
    String? searchQuery,
    Failure? getAllUsersFailure,
    bool clearGetAllUsersFailure = false,
  }) {
    return AdminUsersState(
      users: users ?? this.users,
      usersStatus: usersStatus ?? this.usersStatus,
      deleteUserFailure: clearDeleteUserFailure
          ? null
          : deleteUserFailure ?? this.deleteUserFailure,
      deletingUserId: clearDeletingUserId
          ? null
          : deletingUserId ?? this.deletingUserId,
      searchQuery: searchQuery ?? this.searchQuery,
      getAllUsersFailure: clearGetAllUsersFailure
          ? null
          : getAllUsersFailure ?? this.getAllUsersFailure,
    );
  }
}
