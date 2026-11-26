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
  bool allows(AppArea appArea) {
    switch (this) {
      case RouteAccess.splash:
      case RouteAccess.guestOnly:
      case RouteAccess.onboardingOnly:
        return false;

      case RouteAccess.authenticated:
        return true;
      case RouteAccess.employeeArea:
        return appArea == AppArea.employee;
      case RouteAccess.managerArea:
        return appArea == AppArea.manager;
      case RouteAccess.adminArea:
        return appArea == AppArea.admin;
    }
  }
}
