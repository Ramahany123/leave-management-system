import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final double? width;
  final double? height;
  const OutlinedButtonWidget({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.borderSideColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? context.colorScheme.surface,
        fixedSize: Size(width ?? double.infinity, height ?? 56.h),
        side: BorderSide(
          width: 2.w,
          color: borderSideColor ?? context.colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: child,
    );
  }
}
