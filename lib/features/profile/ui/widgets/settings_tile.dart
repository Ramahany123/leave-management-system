import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final String? subTitle;
  final Widget? trailing;
  final Color? contentColor;
  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.subTitle,
    this.trailing,
    this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.cardBorderColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: contentColor),
      ),
      title: Text(title),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: TextStyle(color: contentColor?.withValues(alpha: 0.7)),
            )
          : null,
      trailing:
          trailing ??
          Icon(Icons.keyboard_arrow_right, size: 24.sp, color: contentColor),
      textColor: contentColor,
    );
  }
}
