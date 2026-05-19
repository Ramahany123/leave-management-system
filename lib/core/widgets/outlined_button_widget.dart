import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final double? width;
  final double? height;
  const OutlinedButtonWidget({
    super.key,
    required this.onPressed,
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
        backgroundColor: backgroundColor,
        fixedSize: Size(width ?? double.infinity, height ?? 56.h),
        side: BorderSide(
          width: 2.w,
          color: borderSideColor ?? AppColors.primaryBlue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: child,
    );
  }
}
