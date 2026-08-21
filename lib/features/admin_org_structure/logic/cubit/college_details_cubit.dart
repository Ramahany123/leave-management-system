import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/networking/errors/failures.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/data/repo/admin_org_repo.dart';

part 'college_details_state.dart';

class CollegeDetailsCubit extends Cubit<CollegeDetailsState> {
  final AdminOrgRepo _orgRepo;

  CollegeDetailsCubit({required AdminOrgRepo orgRepo})
    : _orgRepo = orgRepo,
      super(CollegeDetailsInitial());

  Future<void> getCollegeDetails(int collegeId) async {
    emit(CollegeDetailsLoading());
    final result = await _orgRepo.getCollege(collegeId);
    result.fold(
      (college) {
        emit(CollegeDetailsSuccess(college: college));
      },
      (failure) {
        emit(CollegeDetailsError(failure: failure));
      },
    );
  }
}
