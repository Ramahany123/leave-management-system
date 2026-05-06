import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/data/models/login_response_model.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthInitial());

  Future<void> login(LoginBodyModel loginBody) async {
    emit(AuthLoading());
    final result = await _authRepo.login(loginBody);
    result.fold(
      (loginResponse) {
        switch (loginResponse.status) {
          case AuthStatus.authenticated:
            emit(AuthAuthenticated(user: loginResponse.user!));
            break;
          case AuthStatus.activationRequired:
            emit(AuthNeedActivation(user: loginResponse.user!));
            break;
          case AuthStatus.unauthenticated:
            emit(
              AuthError(
                failure: ServerFailure(
                  "Invalid credentials. Please check your email and SSN.",
                ),
              ),
            );
            break;
        }
      },
      (failure) {
        emit(AuthError(failure: failure));
      },
    );
  }
}
