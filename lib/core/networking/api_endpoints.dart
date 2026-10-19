class ApiEndpoints {
  static const baseUrl = "https://leave-system-1af0.onrender.com/api/";
  //Auth
  static const login = "auth/login";
  static const activateUser = "auth/complete-onboarding";

  //Employee
  static const employeeDashboard = "me/dashboard";
  static const getDelegateUsers = "me/users";
  static const getEligibleLeaveTypes = "me/eligible-leave-types";
  static const createLeaveRequest = "me/leave-requests";
  static const getLeaveRequestsHistory = "me/leave-requests";
  static String getLeaveRequestDetails(int id) => "me/leave-requests/$id";

  //Profile
  static const getProfile = "profile";
  static const changePassword = "profile/change-password";
  static const updateContact = "profile/update-info";
  static const uploadSignature = "profile/signature";

  //Manager
  static const getManagerDashboard = "manager/dashboard";
  static const getApprovalTasks = "manager/approval-tasks";
  static String getApprovalTaskDetails(int stepId) =>
      "manager/approval-tasks/$stepId";
  static String approveTask(int stepId) =>
      "manager/approval-tasks/$stepId/approve";
  static String rejectTask(int stepId) =>
      "manager/approval-tasks/$stepId/reject";
  static const getMembersOnLeave = "manager/team-on-leave";
  static String getManagerReport = "manager/reports";

  //Admin
  static const adminDepartments = "admin/departments";
  static String adminDepartment(int id) => "admin/departments/$id";
  static const adminColleges = "admin/colleges";
  static String adminCollege(int id) => "admin/colleges/$id";

  static const adminAllUsers = "admin/users";
  static String adminUser(int id) => "admin/users/$id";

  static const adminLeaveTypes = "admin/leave-types";
  static String adminLeaveType(int id) => "admin/leave-types/$id";
  static const adminEligibilityRules = "admin/leave-eligibility";
  static String adminEligibilityRule(int id) => "admin/leave-eligibility/$id";

  static const adminReports = 'admin/leave-requests';
  static String adminReport(int id) =>
      "admin/leave-requests/$id/override-status";
}
