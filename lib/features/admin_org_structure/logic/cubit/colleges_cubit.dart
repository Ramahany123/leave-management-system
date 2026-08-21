import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/admin_org_structure/data/repo/admin_org_repo.dart';

import '../../../../core/networking/errors/failures.dart';
import '../../data/models/all_colleges_model.dart';

part 'colleges_state.dart';

class CollegesCubit extends Cubit<CollegesState> {
  final AdminOrgRepo _orgRepo;
  List<CollegeModel> _allCollegesList = [];
  String _searchQuery = "";
  CollegesCubit({required AdminOrgRepo orgRepo})
    : _orgRepo = orgRepo,
      super(CollegesInitial());

  Future<void> getAllColleges() async {
    emit(CollegesLoading());
    final result = await _orgRepo.getAllColleges();
    result.fold(
      (allCollegesModel) {
        _allCollegesList = allCollegesModel.colleges;
        applyLocalFiltersAndEmit();
      },
      (failure) {
        emit(CollegesError(failure: failure));
      },
    );
  }

  Future<void> deleteCollege(int collegeId) async {
    emit(CollegesLoading());
    final result = await _orgRepo.deleteCollege(collegeId);
    result.fold(
      (_) async {
        await getAllColleges();
      },
      (failure) {
        emit(CollegesError(failure: failure));
      },
    );
  }

  void searchColleges(String query) {
    if (_allCollegesList.isEmpty) return;
    _searchQuery = query;
    applyLocalFiltersAndEmit();
  }

  void applyLocalFiltersAndEmit() {
    var filteredList = _allCollegesList;
    if (_searchQuery.isNotEmpty) {
      final exp = RegExp(RegExp.escape(_searchQuery), caseSensitive: false);
      filteredList = filteredList.where((college) {
        final collegeNameMatch = exp.hasMatch(college.collegeName);
        final deanNameMatch = college.dean == null
            ? false
            : exp.hasMatch(college.dean!.name);
        return collegeNameMatch || deanNameMatch;
      }).toList();
    }
    emit(CollegesSuccess(colleges: filteredList));
  }
}
