import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';

class ManagerBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ManagerBottomNavigationBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: LocaleKeys.navigation_home.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.groups_outlined),
          label: LocaleKeys.navigation_coverage.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bar_chart_outlined),
          label: LocaleKeys.navigation_reports.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: LocaleKeys.navigation_profile.tr(),
        ),
      ],
    );
  }
}
