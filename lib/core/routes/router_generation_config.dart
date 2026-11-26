import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/route_guard.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/features/admin_dashboard/ui/screens/admin_dashboard_screen.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/eligibility_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_form_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/screens/eligibility_list_screen.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/screens/leave_type_form_screen.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/screens/leave_type_list_screen.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/departments_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/screens/admin_org_structure_screen.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_query.dart';
import 'package:leave_management_system/features/admin_reports/logic/cubit/report_cubit.dart';
import 'package:leave_management_system/features/admin_reports/ui/screens/admin_report_screen.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';
import 'package:leave_management_system/features/admin_user_management/logic/cubit/admin_user_form_cubit.dart';
import 'package:leave_management_system/features/admin_user_management/logic/cubit/admin_users_cubit.dart';
import 'package:leave_management_system/features/admin_user_management/ui/screens/admin_user_management_screen.dart';
import 'package:leave_management_system/features/admin_user_management/ui/screens/admin_user_management_form.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import 'package:leave_management_system/features/auth/logic/cubit/change_password_cubit.dart';
import 'package:leave_management_system/features/auth/ui/screens/change_password_screen.dart';
import 'package:leave_management_system/features/auth/ui/screens/onboarding_screen.dart';
import 'package:leave_management_system/features/employee_dashboard/logic/cubit/employee_dashboard_cubit.dart';
import 'package:leave_management_system/features/employee_dashboard/ui/screens/employee_dashboard_screen.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_history_cubit.dart';
import 'package:leave_management_system/features/leave_history/ui/screens/leave_history_screen.dart';
import 'package:leave_management_system/features/leave_request/logic/cubit/leave_request_cubit.dart';
import 'package:leave_management_system/features/leave_request/ui/screens/leave_request_screen.dart';
import 'package:leave_management_system/features/main_layout/ui/screens/main_layout.dart';
import 'package:leave_management_system/features/manager_coverage/logic/cubit/manager_coverage_cubit.dart';
import 'package:leave_management_system/features/manager_coverage/ui/screens/manager_coverage_screen.dart';
import 'package:leave_management_system/features/manager_dashboard/logic/cubit/manager_dashboard_cubit.dart';
import 'package:leave_management_system/features/manager_dashboard/logic/cubit/manager_pending_approvals_cubit.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/screens/manager_dashboard_screen.dart';
import 'package:leave_management_system/features/manager_dashboard/ui/screens/manager_pending_approvals_screen.dart';
import 'package:leave_management_system/features/manager_reports/ui/screens/manager_reports_screen.dart';
import 'package:leave_management_system/features/profile/logic/cubit/update_contact_cubit.dart';
import 'package:leave_management_system/features/profile/ui/screens/profile_screen.dart';
import 'package:leave_management_system/features/profile/ui/screens/update_contact_screen.dart';
import 'package:leave_management_system/features/splash/ui/screens/splash_screen.dart';
import '../../features/admin_org_structure/logic/cubit/colleges_cubit.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/ui/screens/no_access_screen.dart';
import '../../features/auth/ui/screens/not_found_screen.dart';
import '../../features/manager_reports/logic/cubit/manager_report_cubit.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
import 'app_routes.dart';
import '../../features/auth/ui/screens/login_screen.dart';

class RouterGenerationConfig {
  static final goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    refreshListenable: sl<AuthRepo>(),
    redirect: (context, state) {
      // `state.name` is null in a top-level redirect (go_router documents it);
      // the leaf route's name is only reachable through `topRoute`.
      return redirectFor(_snapshot(), state.topRoute?.name);
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
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      sl<EmployeeDashboardCubit>()..getEmployeeDashboard(),
                  child: EmployeeDashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.leaveRequestScreen,
                name: AppRoutes.leaveRequestScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => sl<LeaveRequestCubit>()..loadFormData(),
                  child: LeaveRequestScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.leaveHistoryScreen,
                name: AppRoutes.leaveHistoryScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      sl<LeaveHistoryCubit>()..getLeaveHistory(),
                  child: LeaveHistoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileScreen,
                name: AppRoutes.profileScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => sl<ProfileCubit>()..getProfile(),
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.managerDashboardScreen,
                name: AppRoutes.managerDashboardScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      sl<ManagerDashboardCubit>()..getManagerDashboard(),
                  child: ManagerDashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.managerCoverageScreen,
                name: AppRoutes.managerCoverageScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      sl<ManagerCoverageCubit>()..getTeamOnLeave(),
                  child: ManagerCoverageScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.managerReportsScreen,
                name: AppRoutes.managerReportsScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      sl<ManagerReportCubit>()..getManagerReports(),
                  child: ManageReportsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.managerProfileScreen,
                name: AppRoutes.managerProfileScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => sl<ProfileCubit>()..getProfile(),
                  child: ProfileScreen(),
                ),
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
        path: AppRoutes.noAccessScreen,
        name: AppRoutes.noAccessScreen,
        builder: (context, state) => const NoAccessScreen(),
      ),

      GoRoute(
        path: AppRoutes.adminDashboardScreen,
        name: AppRoutes.adminDashboardScreen,
        builder: (context, state) => AdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.changePasswordScreen,
        name: AppRoutes.changePasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<ChangePasswordCubit>(),
          child: ChangePasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.updateContactScreen,
        name: AppRoutes.updateContactScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<UpdateContactCubit>(),
          child: UpdateContactScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.managerPendingApprovalsScreen,
        name: AppRoutes.managerPendingApprovalsScreen,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              sl<ManagerPendingApprovalsCubit>()..fetchPendingApprovals(),
          child: ManagerPendingApprovalsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminOrgStructureScreen,
        name: AppRoutes.adminOrgStructureScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<CollegesCubit>()..getAllColleges(),
            ),
            BlocProvider(
              create: (context) => sl<DepartmentsCubit>()..getAllDepartments(),
            ),
          ],
          child: AdminOrgStructureScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminProfileScreen,
        name: AppRoutes.adminProfileScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<ProfileCubit>()..getProfile(),
          child: ProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminUserManagementScreen,
        name: AppRoutes.adminUserManagementScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AdminUsersCubit>()..getAllUsers(),
          child: AdminUserManagementScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminUserManagementFormScreen,
        name: AppRoutes.adminUserManagementFormScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AdminUserFormCubit>()),
            BlocProvider(
              create: (context) => sl<CollegesCubit>()..getAllColleges(),
            ),
            BlocProvider(create: (context) => sl<DepartmentsCubit>()),
          ],
          child: AdminUserManagementForm(user: state.extra as AdminUserModel?),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminLeaveTypeListScreen,
        name: AppRoutes.adminLeaveTypeListScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<LeaveTypeCubit>()..getLeaveTypes(),
          child: LeaveTypeListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminLeaveTypeFormScreen,
        name: AppRoutes.adminLeaveTypeFormScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<LeaveTypeFormCubit>(),
          child: LeaveTypeFormScreen(leaveType: state.extra as LeaveType?),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminEligibilityListScreen,
        name: AppRoutes.adminEligibilityListScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<LeaveTypeCubit>()..getLeaveTypes(),
            ),
            BlocProvider(
              create: (context) =>
                  sl<EligibilityCubit>()..getEligibilityRules(),
            ),
          ],
          child: EligibilityListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminReportsScreen,
        name: AppRoutes.adminReportsScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ReportCubit>()..applyQuery(ReportQuery()),
            ),
            //TODO: Temporary until i use stored value
            BlocProvider(
              lazy: false,
              create: (context) => sl<DepartmentsCubit>()..getAllDepartments(),
            ),
            BlocProvider(
              lazy: false,
              create: (context) => sl<LeaveTypeCubit>()..getLeaveTypes(),
            ),
          ],
          child: AdminReportScreen(),
        ),
      ),
      // Catch-all: must stay last. Registering it means `findMatch` never
      // fails, so unknown locations land here instead of the guard's
      // `tier == null` branch, and `errorBuilder` only sees redirect errors.
      GoRoute(
        path: '/:unknownPath(.*)',
        name: AppRoutes.notFoundScreen,
        builder: (context, state) =>
            NotFoundScreen(onGoHome: () => context.go(homeFor(_snapshot()))),
      ),
    ],
  );

  /// The policy inputs, built from the repository in one place.
  static AuthSnapshot _snapshot() {
    final authRepo = sl<AuthRepo>();
    return AuthSnapshot(
      status: authRepo.currentAuthStatus,
      role: authRepo.userRole,
      area: authRepo.currentArea,
    );
  }
}
