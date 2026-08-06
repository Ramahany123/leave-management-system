import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';

class ManagerCoverageScreen extends StatefulWidget {
  const ManagerCoverageScreen({super.key});

  @override
  State<ManagerCoverageScreen> createState() => _ManagerCoverageScreenState();
}

class _ManagerCoverageScreenState extends State<ManagerCoverageScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              CustomSearchField(
                controller: _searchController,
                hintText: LocaleKeys.manager_coverage_search_hint.tr(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
