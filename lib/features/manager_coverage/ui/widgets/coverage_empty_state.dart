import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/language/locale_keys.g.dart';
import '../../../../core/theme/theme_context_extension.dart';

class CoverageEmptyState extends StatelessWidget {
  final bool isSearching;
  const CoverageEmptyState({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Text(
          isSearching
              ? LocaleKeys.manager_coverage_no_matching_results.tr()
              : LocaleKeys.manager_coverage_no_members_on_leave.tr(),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
