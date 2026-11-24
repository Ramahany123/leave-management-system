import 'package:leave_management_system/core/routes/route_access.dart';

class AppRoute {
  final String path;
  final RouteAccess access;
  const AppRoute(this.path, this.access);
}

class AppRoutes {
  // Entry / auth machine
  static const splashScreen = "/splashScreen";
  static const loginScreen = "/login";
  static const onboardingScreen = "/onboarding";

  // Employee shell
  static const employeeDashboardScreen = "/employeeDashboard";
  static const leaveRequestScreen = "/leaveRequest";
  static const leaveHistoryScreen = "/leaveHistory";
  static const profileScreen = "/profile";

  // Manager shell
  static const managerDashboardScreen = "/managerDashboard";
  static const managerCoverageScreen = "/managerCoverage";
  static const managerReportsScreen = "/managerReports";
  static const managerProfileScreen = "/managerProfile";
  static const managerPendingApprovalsScreen = "/managerPendingApprovals";

  // Admin
  static const adminDashboardScreen = "/adminDashboard";
  static const adminOrgStructureScreen = "/adminOrgStructure";
  static const adminProfileScreen = "/adminProfileScreen";
  static const adminUserManagementScreen = "/adminUserManagementScreen";
  static const adminUserManagementFormScreen = "/adminUserManagementFormScreen";
  static const adminLeaveTypeListScreen = "/adminLeaveTypeListScreen";
  static const adminLeaveTypeFormScreen = "/adminLeaveTypeFormScreen";
  static const adminEligibilityListScreen = "/adminEligibilityListScreen";
  static const adminReportsScreen = "/adminReportsScreen";

  // Shared by every signed-in persona
  static const changePasswordScreen = "/changePasswordScreen";
  static const updateContactScreen = "/updateContactScreen";

  // ---------------------------------------------------------------------------
  static const List<AppRoute> routeTable = [
    AppRoute(splashScreen, RouteAccess.splash),
    AppRoute(loginScreen, RouteAccess.guestOnly),
    AppRoute(onboardingScreen, RouteAccess.onboardingOnly),

    AppRoute(employeeDashboardScreen, RouteAccess.employeeArea),
    AppRoute(leaveRequestScreen, RouteAccess.employeeArea),
    AppRoute(leaveHistoryScreen, RouteAccess.employeeArea),
    AppRoute(profileScreen, RouteAccess.employeeArea),

    AppRoute(managerDashboardScreen, RouteAccess.managerArea),
    AppRoute(managerCoverageScreen, RouteAccess.managerArea),
    AppRoute(managerReportsScreen, RouteAccess.managerArea),
    AppRoute(managerProfileScreen, RouteAccess.managerArea),
    AppRoute(managerPendingApprovalsScreen, RouteAccess.managerArea),

    AppRoute(adminDashboardScreen, RouteAccess.adminArea),
    AppRoute(adminOrgStructureScreen, RouteAccess.adminArea),
    AppRoute(adminProfileScreen, RouteAccess.adminArea),
    AppRoute(adminUserManagementScreen, RouteAccess.adminArea),
    AppRoute(adminUserManagementFormScreen, RouteAccess.adminArea),
    AppRoute(adminLeaveTypeListScreen, RouteAccess.adminArea),
    AppRoute(adminLeaveTypeFormScreen, RouteAccess.adminArea),
    AppRoute(adminEligibilityListScreen, RouteAccess.adminArea),
    AppRoute(adminReportsScreen, RouteAccess.adminArea),

    AppRoute(changePasswordScreen, RouteAccess.authenticated),
    AppRoute(updateContactScreen, RouteAccess.authenticated),
  ];

  static final Map<String, RouteAccess> accessByName = {
    for (final route in routeTable) route.path: route.access,
  };
}
