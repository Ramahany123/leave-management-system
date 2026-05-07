import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import 'package:leave_management_system/features/auth/ui/screens/onboarding_screen.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/screens/employee_dashboard_screen.dart';
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

      if (authStatus == AuthStatus.unauthenticated) {
        return isLoggingIn ? null : AppRoutes.loginScreen;
      }
      if (isLoggingIn || isSplash) {
        return (authStatus == AuthStatus.activationRequired)
            ? AppRoutes.onboardingScreen
            : AppRoutes.employeeDashboardScreen;
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
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.employeeDashboardScreen,
        name: AppRoutes.employeeDashboardScreen,
        builder: (context, state) => EmployeeDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
    ],
  );
}
