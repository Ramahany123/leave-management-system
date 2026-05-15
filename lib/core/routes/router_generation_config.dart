import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/features/admin_dashboard/ui/screens/admin_dashboard_screen.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import 'package:leave_management_system/features/auth/ui/screens/onboarding_screen.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/screens/employee_dashboard_screen.dart';
import 'package:leave_management_system/features/leave_history/ui/screens/leave_history_screen.dart';
import 'package:leave_management_system/features/leave_request/ui/screens/leave_request_screen.dart';
import 'package:leave_management_system/features/main_layout/ui/screens/main_layout.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/screens/manager_dashboard_screen.dart';
import 'package:leave_management_system/features/profile/ui/screens/profile_screen.dart';
import 'package:leave_management_system/features/splash/ui/screens/splash_screen.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../constants/enums.dart';
import 'app_routes.dart';
import '../../features/auth/ui/screens/login_screen.dart';

class RouterGenerationConfig {
  static final goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    refreshListenable: sl<AuthRepo>(),
    redirect: (context, state) {
      final AuthStatus authStatus = sl<AuthRepo>().currentAuthStatus;
      final bool isLoggingIn = state.matchedLocation == AppRoutes.loginScreen;
      final bool isSplash = state.matchedLocation == AppRoutes.splashScreen;
      final bool isOnboarding =
          state.matchedLocation == AppRoutes.onboardingScreen;
      final bool isManagerRoute =
          state.matchedLocation == AppRoutes.managerDashboardScreen;
      final bool isAdminRoute =
          state.matchedLocation == AppRoutes.adminDashboardScreen;
      final String userRole = sl<AuthRepo>().userRole;

      if (authStatus == AuthStatus.unauthenticated) {
        return isLoggingIn ? null : AppRoutes.loginScreen;
      }
      if (authStatus == AuthStatus.activationRequired) {
        return isOnboarding ? null : AppRoutes.onboardingScreen;
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isLoggingIn || isSplash || isOnboarding) {
          if (userRole == UserRoles.employeeRole) {
            return AppRoutes.employeeDashboardScreen;
          } else if (userRole == UserRoles.adminRole) {
            return AppRoutes.adminDashboardScreen;
          } else if (UserRoles.managerRoles.contains(userRole)) {
            return AppRoutes.managerDashboardScreen;
          }
        }

        // To prevent access from employee to other roles
        if (userRole == UserRoles.employeeRole &&
            (isManagerRoute || isAdminRoute)) {
          return AppRoutes.employeeDashboardScreen;
        }
        //to prevent access from manager to admin role
        if (UserRoles.managerRoles.contains(userRole) && isAdminRoute) {
          return AppRoutes.managerDashboardScreen;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: OnboardingScreen(),
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.employeeDashboardScreen,
                name: AppRoutes.employeeDashboardScreen,
                builder: (context, state) => EmployeeDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.leaveRequestScreen,
                name: AppRoutes.leaveRequestScreen,
                builder: (context, state) => LeaveRequestScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.leaveHistoryScreen,
                name: AppRoutes.leaveHistoryScreen,
                builder: (context, state) => LeaveHistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileScreen,
                name: AppRoutes.profileScreen,
                builder: (context, state) => ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.managerDashboardScreen,
        name: AppRoutes.managerDashboardScreen,
        builder: (context, state) => ManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminDashboardScreen,
        name: AppRoutes.adminDashboardScreen,
        builder: (context, state) => AdminDashboardScreen(),
      ),
    ],
  );
}
