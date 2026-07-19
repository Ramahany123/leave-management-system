import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/enums.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';
import 'package:leave_management_system/features/main_layout/ui/widgets/manager_bottom_navigation_bar.dart';

import '../../../../core/utils/service_locator.dart';
import '../widgets/employee_bottom_navigation_bar.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: sl<AuthRepo>(),
      builder: (BuildContext context, _) {
        final bool isManagerView =
            sl<AuthRepo>().currentViewMode == ViewMode.manager;
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: isManagerView
              ? ManagerBottomNavigationBar(navigationShell: navigationShell)
              : EmployeeBottomNavigationBar(navigationShell: navigationShell),
        );
      },
    );
  }
}
