class AppRoutes {
  static const loginScreen = "/login";
  static const onboardingScreen = "/onboarding";
  static const employeeDashboardScreen = "/employeeDashboard";
  static const splashScreen = "/splashScreen";

  //Employee Routes
  static const leaveRequestScreen = "/leaveRequest";
  static const leaveHistoryScreen = "/leaveHistory";
  static const profileScreen = "/profile";
  static const changePasswordScreen = "/changePasswordScreen";
  static const updateContactScreen = "/updateContactScreen";
  static const employeeRoutes = [
    leaveRequestScreen,
    leaveHistoryScreen,
    profileScreen,
    changePasswordScreen,
    updateContactScreen,
  ];

  //Manager Routes
  static const managerDashboardScreen = "/managerDashboard";
  static const managerPendingApprovalsScreen = "/managerPendingApprovals";
  static const managerCoverageScreen = "/managerCoverage";
  static const managerReportsScreen = "/managerReports";
  static const managerProfileScreen = "/managerProfile";
  static const managerRoutes = [
    managerCoverageScreen,
    managerDashboardScreen,
    managerPendingApprovalsScreen,
    managerPendingApprovalsScreen,
    managerProfileScreen,
    managerReportsScreen,
  ];

  //Admin Routes
  static const adminDashboardScreen = "/adminDashboard";
  static const adminOrgStructureScreen = "/adminOrgStructure";
  static const adminProfileScreen = "/adminProfileScreen";
  static const adminUserManagementScreen = "/adminUserManagementScreen";
  static const adminUserManagementFormScreen = "/adminUserManagementFormScreen";

  static const adminRoutes = [
    adminDashboardScreen,
    adminOrgStructureScreen,
    adminProfileScreen,
    adminUserManagementScreen,
    adminUserManagementFormScreen,
  ];
}
