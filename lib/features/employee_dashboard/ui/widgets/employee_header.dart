import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/name_avatar.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';

import '../../../../core/utils/service_locator.dart';

class EmployeeHeader extends StatelessWidget {
  const EmployeeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = sl<AuthRepo>().userName;
    return Row(
      children: [
        NameAvatar(name: name),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.dashboard_good_morning.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                name,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
