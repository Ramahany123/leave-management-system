import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Text("Select Language", style: context.textTheme.titleLarge),
          SizedBox(height: 16.h),
          _LanguageTile(
            title: "English",
            isSelected: currentLocale == 'en',
            onTap: () => _changeLanguage(context, 'en'),
          ),
          const Divider(),
          _LanguageTile(
            title: "العربية",
            isSelected: currentLocale == 'ar',
            onTap: () => _changeLanguage(context, 'ar'),
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, String code) {
    context.setLocale(Locale(code));
    Navigator.pop(context);
  }
}

class _LanguageTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const _LanguageTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.onSurface,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: context.colorScheme.primary)
          : null,
    );
  }
}
