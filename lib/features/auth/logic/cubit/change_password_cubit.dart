import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/auth/data/models/change_password_body_model.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepo _authRepo;
  ChangePasswordCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(ChangePasswordInitial());

  Future<void> changePassword(
    ChangePasswordBodyModel changePasswordBody,
  ) async {
    emit(ChangePasswordLoading());
    final result = await _authRepo.changePassword(changePasswordBody);
    //TODO: localize Text
    result.fold(
      (response) {
        emit(ChangePasswordSuccess(message: "Password Changed Successfully"));
      },
      (failure) {
        emit(ChangePasswordError(failure: failure));
      },
    );
  }
}
