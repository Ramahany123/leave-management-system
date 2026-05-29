import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/models/user_model.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo,
      super(ProfileLoading()) {
    _profileRepo.addListener(_onProfileRepoChanged);
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await _profileRepo.getProfile();
    result.fold(
      (profileResponseModel) {
        emit(ProfileSuccess(user: profileResponseModel.user));
      },
      (failure) {
        emit(ProfileError(failure: failure));
      },
    );
  }

  void _onProfileRepoChanged() {
    if (_profileRepo.currentUser != null) {
      emit(ProfileSuccess(user: _profileRepo.currentUser!));
    }
  }

  @override
  Future<void> close() {
    _profileRepo.removeListener(_onProfileRepoChanged);
    return super.close();
  }
}
