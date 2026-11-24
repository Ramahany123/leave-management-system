import '../constants/app_constants.dart';
import '../constants/enums.dart';
import 'app_routes.dart';
import 'route_access.dart';

class AuthSnapshot {
  const AuthSnapshot({
    required this.status,
    required this.role,
    required this.viewMode,
  });

  final AuthStatus status;
  final String role;
  final ViewMode viewMode;

  bool get isAdmin => role == UserRoles.adminRole;

  bool get isManagerRole => UserRoles.managerRoles.contains(role);

  bool get hasKnownRole => UserRoles.allRoles.contains(role);
}

String homeFor(AuthSnapshot auth) {
  if (!auth.hasKnownRole) return AppRoutes.noAccessScreen;
  if (auth.isAdmin) return AppRoutes.adminDashboardScreen;
  if (auth.isManagerRole && auth.viewMode == ViewMode.manager) {
    return AppRoutes.managerDashboardScreen;
  }
  return AppRoutes.employeeDashboardScreen;
}

/// The single routing decision of the app.
///
/// Returns `null` to allow the navigation (go_router's convention: `null`
/// means "no redirect") or the location to redirect to.
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

  if (tier == null) return homeFor(auth);

  return tier.allows(auth.role, auth.viewMode) ? null : homeFor(auth);
}
