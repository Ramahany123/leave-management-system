import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';
import 'package:leave_management_system/features/admin_user_management/data/repo/admin_user_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'admin_users_state.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  final AdminUserRepo _adminUserRepo;
  List<AdminUserModel> _allUsersList = [];
  List<AdminUserModel> _filterUsers(String query) {
    var filteredList = _allUsersList;
    if (query.isNotEmpty) {
      final exp = RegExp(RegExp.escape(query), caseSensitive: false);
      filteredList = filteredList.where((user) {
        final nameMatch = exp.hasMatch(user.name);
        final emailMatch = exp.hasMatch(user.email);
        final roleMatch = exp.hasMatch(user.role);
        return nameMatch || emailMatch || roleMatch;
      }).toList();
    }
    return filteredList;
  }

  AdminUsersCubit({required AdminUserRepo adminUserRepo})
    : _adminUserRepo = adminUserRepo,
      super(AdminUsersState());

  Future<void> getAllUsers() {
    return _getUsers(UsersStatus.loading);
  }

  Future<void> refreshUsers() {
    return _getUsers(UsersStatus.refreshing);
  }

  Future<void> _getUsers(UsersStatus usersStatus) async {
    emit(
      state.copyWith(usersStatus: usersStatus, clearGetAllUsersFailure: true),
    );
    final result = await _adminUserRepo.getAllUsers();
    result.fold(
      (userResponse) {
        _allUsersList = userResponse.users;
        emit(
          state.copyWith(
            users: _filterUsers(state.searchQuery),
            usersStatus: UsersStatus.success,
          ),
        );
      },
      (failure) {
        emit(
          state.copyWith(
            getAllUsersFailure: failure,
            usersStatus: usersStatus == UsersStatus.loading
                ? UsersStatus.failure
                : UsersStatus.refreshFailure,
          ),
        );
      },
    );
  }

  Future<void> deleteUser(int id) async {
    emit(state.copyWith(deletingUserId: id, clearDeleteUserFailure: true));
    final result = await _adminUserRepo.deleteUser(id);
    result.fold(
      (_) {
        _allUsersList.removeWhere((user) => user.userId == id);
        emit(
          state.copyWith(
            clearDeletingUserId: true,
            users: _filterUsers(state.searchQuery),
          ),
        );
      },
      (failure) {
        emit(
          state.copyWith(deleteUserFailure: failure, clearDeletingUserId: true),
        );
      },
    );
  }

  void clearDeleteUserFailure() {
    emit(state.copyWith(clearDeleteUserFailure: true));
  }

  void clearRefreshFailure() {
    emit(state.copyWith(clearGetAllUsersFailure: true));
  }

  void searchUsers(String query) {
    emit(state.copyWith(users: _filterUsers(query), searchQuery: query));
  }
}
