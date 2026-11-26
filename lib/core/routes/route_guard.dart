import '../constants/app_constants.dart';
import '../constants/enums.dart';
import 'app_routes.dart';
import 'route_access.dart';

class AuthSnapshot {
  AuthSnapshot({
    required this.status,
    required this.role,
    required AppArea area,
  }) : area = PersonaAreas.areasFor(role).contains(area)
           ? area
           : PersonaAreas.primaryAreaFor(role) ?? AppArea.employee;

  final AuthStatus status;
  final String role;
  final AppArea area;

  bool get hasKnownRole => UserRoles.allRoles.contains(role);
}

String homeFor(AuthSnapshot auth) {
  if (!auth.hasKnownRole) return AppRoutes.noAccessScreen;
  return switch (auth.area) {
    AppArea.employee => AppRoutes.employeeDashboardScreen,
    AppArea.manager => AppRoutes.managerDashboardScreen,
    AppArea.admin => AppRoutes.adminDashboardScreen,
  };
}

String? redirectFor(AuthSnapshot auth, String? routeName) {
  final RouteAccess? tier = AppRoutes.accessByName[routeName];
  switch (auth.status) {
    case AuthStatus.initial:
      return tier == RouteAccess.splash ? null : AppRoutes.splashScreen;
    case AuthStatus.unauthenticated:
      return tier == RouteAccess.guestOnly ? null : AppRoutes.loginScreen;
    case AuthStatus.activationRequired:
      return tier == RouteAccess.onboardingOnly
          ? null
          : AppRoutes.onboardingScreen;
    case AuthStatus.authenticated:
      break;
  }

  if (!auth.hasKnownRole) {
    return tier == RouteAccess.unknownRoleOnly ? null : homeFor(auth);
  }

  if (tier == null) return homeFor(auth);

  return tier.allows(auth.area) ? null : homeFor(auth);
}
