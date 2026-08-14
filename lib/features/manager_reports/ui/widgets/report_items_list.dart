import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_item_card.dart';

import '../../data/models/manager_reports_model.dart';

class ReportItemsList extends StatelessWidget {
  const ReportItemsList({super.key, required this.filteredReports});

  final List<ReportRecord> filteredReports;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) =>
          ReportItemCard(record: filteredReports[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: filteredReports.length,
    );
  }
}
