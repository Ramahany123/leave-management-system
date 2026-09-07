import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/colleges_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/departments_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/college_tab_view.dart';
import 'package:leave_management_system/features/admin_org_structure/ui/widgets/departments_tab_view.dart';

class AdminOrgStructureScreen extends StatefulWidget {
  const AdminOrgStructureScreen({super.key});

  @override
  State<AdminOrgStructureScreen> createState() =>
      _AdminOrgStructureScreenState();
}

class _AdminOrgStructureScreenState extends State<AdminOrgStructureScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCollegesTab = _tabController.index == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizational Structure"),
        bottom: TabBar(
          tabs: const [
            Tab(text: "Colleges", icon: Icon(Icons.account_balance_outlined)),
            Tab(text: "Departments", icon: Icon(Icons.business_outlined)),
          ],
          controller: _tabController,
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [CollegeTabView(), DepartmentsTabView()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isCollegesTab ? "Add College" : "Add Department",
        onPressed: () async {
          if (isCollegesTab) {
            final bool? isCreated = await AppDialogs.showCollegeFormSheet(
              context,
            );
            if (isCreated == true && context.mounted) {
              context.read<CollegesCubit>().getAllColleges();
            }
          } else {
            final bool? isCreated = await AppDialogs.showDeparmtentFormSheet(
              context,
            );
            if (isCreated == true && context.mounted) {
              context.read<DepartmentsCubit>().getAllDepartments();
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
