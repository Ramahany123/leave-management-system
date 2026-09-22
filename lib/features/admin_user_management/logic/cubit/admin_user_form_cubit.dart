import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/create_user_request_model.dart';

import '../../data/models/update_user_request_model.dart';
import '../../data/repo/admin_user_repo.dart';

part 'admin_user_form_state.dart';

class AdminUserFormCubit extends Cubit<AdminUserFormState> {
  final AdminUserRepo _adminUserRepo;

  AdminUserFormCubit({required AdminUserRepo adminUserRepo})
    : _adminUserRepo = adminUserRepo,
      super(AdminUserFormInitial());

  Future<void> createUser(CreateUserRequestModel requestBody) async {
    emit(AdminUserFormLoading());
    final result = await _adminUserRepo.createUser(requestBody);
    result.fold(
      (_) {
        emit(AdminUserFormSuccess());
      },
      (failure) {
        emit(AdminUserFormError(failure: failure));
      },
    );
  }

  Future<void> updateUser(UpdateUserRequestModel requestBody, int id) async {
    emit(AdminUserFormLoading());
    final result = await _adminUserRepo.updateUser(requestBody, id);
    result.fold(
      (_) {
        emit(AdminUserFormSuccess());
      },
      (failure) {
        emit(AdminUserFormError(failure: failure));
      },
    );
  }
}
