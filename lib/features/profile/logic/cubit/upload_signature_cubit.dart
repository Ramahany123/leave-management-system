import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/profile/data/models/upload_signature_response_model.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'upload_signature_state.dart';

class UploadSignatureCubit extends Cubit<UploadSignatureState> {
  final ProfileRepo _profileRepo;
  UploadSignatureCubit({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo,
      super(UploadSignatureInitial());

  Future<void> uploadSignature(String filePath) async {
    emit(UploadSignatureLoading());
    final result = await _profileRepo.uploadSignature(filePath);
    if (isClosed) return;
    result.fold(
      (uploadSignatureResponse) {
        emit(
          UploadSignatureSuccess(
            uploadSignatureResponse: uploadSignatureResponse,
          ),
        );
      },
      (failure) {
        emit(UploadSignatureError(failure: failure));
      },
    );
  }
}
