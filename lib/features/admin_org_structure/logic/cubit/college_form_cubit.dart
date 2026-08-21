import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';

import '../../data/repo/admin_org_repo.dart';

part 'college_form_state.dart';

class CollegeFormCubit extends Cubit<CollegeFormState> {
  final AdminOrgRepo _orgRepo;
  CollegeFormCubit({required AdminOrgRepo orgRepo})
    : _orgRepo = orgRepo,
      super(CollegeFormInitial());

  Future<void> createCollege(String collegeName, {int? deanId}) async {
    emit(CollegeFormLoading());
    final result = await _orgRepo.createCollege(collegeName, deanId: deanId);
    result.fold(
      (_) {
        emit(CollegeFormSuccess());
      },
      (failure) {
        emit(CollegeFormError(failure: failure));
      },
    );
  }

  Future<void> updateCollege(int collegeId, {String? name, int? deanId}) async {
    emit(CollegeFormLoading());
    final result = await _orgRepo.updateCollege(
      collegeId,
      name: name,
      deanId: deanId,
    );
    result.fold(
      (_) {
        emit(CollegeFormSuccess());
      },
      (failure) {
        emit(CollegeFormError(failure: failure));
      },
    );
  }
}
