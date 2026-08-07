import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/language/locale_keys.g.dart';
import '../../../../core/theme/theme_context_extension.dart';

class CoverageEmployeeCount extends StatelessWidget {
  const CoverageEmployeeCount({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          LocaleKeys.manager_coverage_active_leaves_count.tr(
            namedArgs: {'count': count.toString()},
          ),
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
