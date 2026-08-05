import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/manager_dashboard/data/models/pending_approval_model.dart';
import 'package:leave_management_system/features/manager_dashboard/data/repo/manager_dashboard_repo.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/networking/errors/failures.dart';

part 'manager_pending_approvals_state.dart';

class ManagerPendingApprovalsCubit extends Cubit<ManagerPendingApprovalsState> {
  final ManagerDashboardRepo _dashboardRepo;
  List<PendingApprovalModel> _allPendingApprovals = [];
  String _searchQuery = '';
  ManagerPendingApprovalsCubit({required ManagerDashboardRepo dashboardRepo})
    : _dashboardRepo = dashboardRepo,
      super(ManagerPendingApprovalsLoading());

  Future<void> fetchPendingApprovals() async {
    emit(ManagerPendingApprovalsLoading());
    final result = await _dashboardRepo.getManagerDashboard();
    result.fold(
      (managerDashboard) {
        _allPendingApprovals = managerDashboard.pendingApprovals;
        _applyFiltersAndEmit();
      },
      (failure) {
        emit(ManagerPendingApprovalsError(failure: failure));
      },
    );
  }

  void searchPendingApprovals(String query) {
    _searchQuery = query;
    _applyFiltersAndEmit();
  }

  void _applyFiltersAndEmit() {
    List<PendingApprovalModel> filteredList = _allPendingApprovals;
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((task) {
        return task.request.leaveTypeName.normalizedContains(_searchQuery) ||
            task.request.user.name.normalizedContains(_searchQuery);
      }).toList();
    }
    emit(ManagerPendingApprovalsSuccess(pendingApprovals: filteredList));
  }
}
