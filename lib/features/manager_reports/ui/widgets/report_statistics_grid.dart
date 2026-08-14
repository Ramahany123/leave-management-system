import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/features/manager_reports/data/models/manager_reports_model.dart';
import 'package:leave_management_system/features/manager_reports/ui/widgets/report_statistics_card.dart';

import '../../../../core/theme/app_colors.dart';

class ReportStatisticsGrid extends StatelessWidget {
  final Statistics? stats;
  const ReportStatisticsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0.r),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 1.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ReportStatisticsCard(
          label: 'Total',
          stat: stats?.total.toString() ?? "-",
          statColor: context.colorScheme.primary,
        ),
        ReportStatisticsCard(
          label: "Pending", // Hardcoded label
          stat: stats?.pending.toString() ?? "-", // Dynamic API data
          statColor: AppColors.pendingAmber,
        ),
        ReportStatisticsCard(
          label: 'Approved',
          stat: stats?.approved.toString() ?? "-",
          statColor: AppColors.successGreen,
        ),
        ReportStatisticsCard(
          label: 'Rejected',
          stat: stats?.rejected.toString() ?? "-",
          statColor: AppColors.errorRed,
        ),
      ],
    );
  }
}
