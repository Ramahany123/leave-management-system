import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/constants/enums.dart';

enum RouteAccess {
  splash,
  guestOnly,
  onboardingOnly,
  authenticated,
  employeeArea,
  managerArea,
  adminArea,
}

extension RouteAccessPolicy on RouteAccess {
  bool allows(String role, ViewMode viewMode) {
    switch (this) {
      case RouteAccess.splash:
      case RouteAccess.guestOnly:
      case RouteAccess.onboardingOnly:
        return false;

      case RouteAccess.authenticated:
        return role.isNotEmpty;
      case RouteAccess.employeeArea:
        return role == UserRoles.employeeRole ||
            (UserRoles.managerRoles.contains(role) &&
                viewMode == ViewMode.employee);
      case RouteAccess.managerArea:
        return UserRoles.managerRoles.contains(role) &&
            viewMode == ViewMode.manager;
      case RouteAccess.adminArea:
        return role == UserRoles.adminRole;
    }
  }
}
