import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/leave_request/data/models/create_leave_request_response_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/leave_requet_body_model.dart';
import 'package:leave_management_system/features/leave_request/data/repo/leave_request_repo.dart';
import 'package:leave_management_system/features/leave_request/logic/leave_request_validator.dart';

import '../../../../core/networking/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/delegate_user_model.dart';
import '../../data/models/eligible_leave_type_model.dart';
import 'leave_request_form_fields.dart';

part 'leave_request_state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final LeaveRequestRepo _leaveRequestRepo;
  LeaveRequestFormFields _formFields = LeaveRequestFormFields();

  LeaveRequestCubit({required LeaveRequestRepo leaveRequestRepo})
    : _leaveRequestRepo = leaveRequestRepo,
      super(LeaveRequestInitial());

  Future<void> loadFormData() async {
    emit(LeaveRequestFormLoading());
    final results = await Future.wait([
      _leaveRequestRepo.getEligibleLeaveTypes(),
      _leaveRequestRepo.getDelegateUsers(),
    ]);

    final typesResult = results[0] as Result<EligibleLeaveTypesResponseModel>;
    final delegatesResult = results[1] as Result<DelegateUsersResponseModel>;
    typesResult.fold(
      (typesResponse) {
        delegatesResult.fold(
          (delegatesResponse) {
            emit(
              LeaveRequestFormSuccess(
                delegateUsers: delegatesResponse.delegateUsers,
                eligibleLeaveTypes: typesResponse.eligibleLeaveTypes,
                formFields: _formFields,
              ),
            );
          },
          (delegatesFailure) {
            emit(LeaveRequestFormError(failure: delegatesFailure));
          },
        );
      },
      (typesFailure) {
        emit(LeaveRequestFormError(failure: typesFailure));
      },
    );
  }

  Future<void> submitLeaveRequest() async {
    final validationError = LeaveRequestValidator.validate(_formFields);
    if (validationError != null) {
      emit(
        LeaveRequestSubmitError(failure: ValidationFailure(validationError)),
      );
      return;
    }
    emit(LeaveRequestSubmitLoading());

    final body = LeaveRequestBodyModel(
      typeId: _formFields.selectedLeaveType!.typeId,
      startDate: _formFields.startDate!,
      endDate: _formFields.endDate!,
      reason: _formFields.reason,
      preLeaveAcknowledgement: _formFields.preLeaveAcknowledgement,
      delegateUserId: _formFields.selectedDelegate?.userId,
      documentFiles: _formFields.selectedFiles,
    );

    final result = await _leaveRequestRepo.createLeaveRequest(body);
    result.fold(
      (leaveRequestResponse) {
        emit(
          LeaveRequestSubmitSuccess(
            createLeaveRequestResponse: leaveRequestResponse,
          ),
        );
      },
      (failure) {
        emit(LeaveRequestSubmitError(failure: failure));
      },
    );
  }

  void selectLeaveType(EligibleLeaveTypeModel type) {
    _formFields = _formFields.copyWith(
      selectedLeaveType: type,
      selectedDelegate: null, // Reset delegate
      selectedFiles: {}, // Reset uploaded files
    );
    _emitSuccessState();
  }

  void selectStartDate(DateTime date) {
    _formFields = _formFields.copyWith(startDate: date);
    _emitSuccessState();
  }

  void selectEndDate(DateTime date) {
    _formFields = _formFields.copyWith(endDate: date);
    _emitSuccessState();
  }

  void updateReason(String text) {
    _formFields = _formFields.copyWith(reason: text);
  }

  void selectDelegate(DelegateUserModel delegate) {
    _formFields = _formFields.copyWith(selectedDelegate: delegate);
    _emitSuccessState();
  }

  void addFile(int requirementId, String path) {
    final updatedFiles = Map<int, String>.from(_formFields.selectedFiles);
    updatedFiles[requirementId] = path;
    _formFields = _formFields.copyWith(selectedFiles: updatedFiles);
    _emitSuccessState();
  }

  void removeFile(int requirementId) {
    final updatedFiles = Map<int, String>.from(_formFields.selectedFiles);
    updatedFiles.remove(requirementId);
    _formFields = _formFields.copyWith(selectedFiles: updatedFiles);
    _emitSuccessState();
  }

  // Private helper to emit the success state with the updated form fields
  void _emitSuccessState() {
    if (state is LeaveRequestFormSuccess) {
      final currentState = state as LeaveRequestFormSuccess;
      emit(
        LeaveRequestFormSuccess(
          delegateUsers: currentState.delegateUsers,
          eligibleLeaveTypes: currentState.eligibleLeaveTypes,
          formFields: _formFields,
        ),
      );
    }
  }
}
