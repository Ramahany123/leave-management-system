import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

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
    final effectiveColor = contentColor ?? context.colorScheme.onSurface;

    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: effectiveColor, size: 20.sp),
      ),
      title: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(color: effectiveColor),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: context.textTheme.bodySmall?.copyWith(
                color: effectiveColor.withValues(alpha: 0.7),
              ),
            )
          : null,
      trailing:
          trailing ??
          Icon(Icons.keyboard_arrow_right, size: 24.sp, color: effectiveColor),
    );
  }
}
