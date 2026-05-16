import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
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
            icon: const Icon(Icons.add_circle),
            label: LocaleKeys.navigation_request.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: LocaleKeys.navigation_history.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: LocaleKeys.navigation_profile.tr(),
          ),
        ],
      ),
    );
  }
}
