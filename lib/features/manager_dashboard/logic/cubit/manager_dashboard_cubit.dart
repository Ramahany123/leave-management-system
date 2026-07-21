import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/manager_dashboard/data/models/manager_dashboard_model.dart';
import 'package:leave_management_system/features/manager_dashboard/data/repo/manager_dashboard_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'manager_dashboard_state.dart';

//TODO: Implement members on leave
class ManagerDashboardCubit extends Cubit<ManagerDashboardState> {
  final ManagerDashboardRepo _managerDashboardRepo;
  ManagerDashboardCubit({required ManagerDashboardRepo managerDashboardRepo})
    : _managerDashboardRepo = managerDashboardRepo,
      super(ManagerDashboardLoading());

  Future<void> getManagerDashboard() async {
    final result = await _managerDashboardRepo.getManagerDashboard();
    result.fold(
      (data) {
        emit(ManagerDashboardSuccess(managerDashboardModel: data));
      },
      (failure) {
        emit(ManagerDashboardError(failure: failure));
      },
    );
  }
}
