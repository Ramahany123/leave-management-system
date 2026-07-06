import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.cardBorderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          // TODO: localize text
          Text("Select Language", style: AppTextStyles.black20w600TextStyle),
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
        style: isSelected
            ? AppTextStyles.primary16w600TextStyle
            : AppTextStyles.black16w500TextStyle,
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
          : null,
    );
  }
}
