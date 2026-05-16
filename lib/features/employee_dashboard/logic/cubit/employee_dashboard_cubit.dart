import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/employee_dashboard/data/models/employee_dashboard_response_model.dart';
import 'package:leave_management_system/features/employee_dashboard/data/repo/employee_dashboard_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'employee_dashboard_state.dart';

class EmployeeDashboardCubit extends Cubit<EmployeeDashboardState> {
  final EmployeeDashboardRepo _employeeDashboardRepo;
  EmployeeDashboardCubit({required EmployeeDashboardRepo employeeDashboardRepo})
    : _employeeDashboardRepo = employeeDashboardRepo,
      super(EmployeeDashboardLoading());

  Future<void> getEmployeeDashboard() async {
    emit(EmployeeDashboardLoading());
    final result = await _employeeDashboardRepo.getEmployeeDashboard();
    result.fold(
      (employeeDashboardResponse) {
        emit(
          EmployeeDashboardSuccess(
            employeeDashboardResponse: employeeDashboardResponse,
          ),
        );
      },
      (failure) {
        emit(EmployeeDashboardError(failure: failure));
      },
    );
  }
}
