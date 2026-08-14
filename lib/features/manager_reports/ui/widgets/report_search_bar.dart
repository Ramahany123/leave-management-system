import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/features/manager_reports/logic/cubit/manager_report_cubit.dart';

import '../../../../core/language/locale_keys.g.dart';

class ReportSearchBar extends StatefulWidget {
  const ReportSearchBar({super.key});

  @override
  State<ReportSearchBar> createState() => _ReportSearchBarState();
}

class _ReportSearchBarState extends State<ReportSearchBar> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField(
      controller: searchController,
      hintText: LocaleKeys.manager_reports_search_hint.tr(),
      onChanged: (query) {
        context.read<ManagerReportCubit>().searchReports(query);
      },
    );
  }
}
