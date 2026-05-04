import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class GeneralErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const GeneralErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.errorRed, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.grey18w400TextStyle,
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Try Again',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
