part of 'manager_pending_approvals_cubit.dart';

@immutable
sealed class ManagerPendingApprovalsState {}

final class ManagerPendingApprovalsLoading
    extends ManagerPendingApprovalsState {}

final class ManagerPendingApprovalsSuccess
    extends ManagerPendingApprovalsState {
  final List<PendingApprovalModel> pendingApprovals;

  ManagerPendingApprovalsSuccess({required this.pendingApprovals});
}

final class ManagerPendingApprovalsError extends ManagerPendingApprovalsState {
  final Failure failure;

  ManagerPendingApprovalsError({required this.failure});
}
