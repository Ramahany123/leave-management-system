import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore_off_outlined,
                size: 64.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 24.h),
              Text(
                LocaleKeys.not_found_title.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge,
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.not_found_message.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 32.h),
              PrimaryButtonWidget(
                width: double.infinity,
                onPressed: onGoHome,
                child: Text(LocaleKeys.not_found_back_home.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
