import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_body_model.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';
import '../../../../core/networking/errors/failures.dart';
import '../../data/models/update_contact_response_model.dart';

part 'update_contact_state.dart';

class UpdateContactCubit extends Cubit<UpdateContactState> {
  final ProfileRepo _profileRepo;
  UpdateContactCubit({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo,
      super(UpdateContactInitial());

  Future<void> updateContact(UpdateContactBodyModel updateContactBody) async {
    emit(UpdateContactLoading());
    final result = await _profileRepo.updateContact(updateContactBody);
    result.fold(
      (final updateContactResponse) {
        emit(
          UpdateContactSuccess(updateContactResponse: updateContactResponse),
        );
      },
      (final failure) {
        emit(UpdateContactError(failure: failure));
      },
    );
  }
}
