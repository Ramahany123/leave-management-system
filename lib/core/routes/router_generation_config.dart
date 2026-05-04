import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/features/auth/ui/screens/login_screen.dart';

class RouterGenerationConfig {
  static final goRouter = GoRouter(
    initialLocation: AppRoutes.loginScreen,
    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
    ],
  );
}
