import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Widget child;
  const PrimaryButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.height,
    this.width,
    this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryBlue,
        fixedSize: Size(width ?? 331.w, height ?? 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: const CircularProgressIndicator(
                color: AppColors.whiteColor,
                strokeWidth: 3,
              ),
            )
          : child,
    );
  }
}
