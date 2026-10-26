import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/admin_reports/data/repo/report_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'override_report_state.dart';

class OverrideReportCubit extends Cubit<OverrideReportState> {
  final ReportRepo _repo;
  OverrideReportCubit({required ReportRepo repo})
    : _repo = repo,
      super(OverrideReportInitial());

  Future<void> overrideStatus({
    required int id,
    required String status,
    required String comments,
  }) async {
    if (state is OverrideReportLoading) return;
    emit(OverrideReportLoading());
    final result = await _repo.overrideStatus(
      id,
      status: status,
      comments: comments,
    );
    if (isClosed) return;
    result.fold(
      (_) {
        emit(OverrideReportSuccess());
      },
      (failure) {
        emit(OverrideReportError(failure: failure));
      },
    );
  }
}
