class ApiEndpoints {
  static const baseUrl = "https://leave-system-1af0.onrender.com/api/";
  static const login = "auth/login";
  static const activateUser = "auth/complete-onboarding";
  static const employeeDashboard = "me/dashboard";
  static const getDelegateUsers = "me/users";
  static const getEligibleLeaveTypes = "me/eligible-leave-types";
  static const createLeaveRequest = "me/leave-requests";
  static const getLeaveRequestsHistory = "me/leave-requests";
  static String getLeaveRequestDetails(int id) => "me/leave-requests/$id";
  static const getProfile = "profile";
  static const changePassword = "profile/change-password";
  static const updateContact = "profile/update-info";
  static const uploadSignature = "profile/signature";

  static const getManagerDashboard = "manager/dashboard";
  static const getApprovalTasks = "manager/approval-tasks";
  static String getApprovalTaskDetails(int id) => "manager/approval-tasks/:$id";
  static String approveTask(int id) => "manager/approval-tasks/:$id/approve";
  static String rejectTask(int id) => "manager/approval-tasks/:$id/reject";
  static const getMembersOnLeave = "manager/team-on-leave";
  static String getManagerReport = "manager/reports";
}
