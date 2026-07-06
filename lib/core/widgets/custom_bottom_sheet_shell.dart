import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomBottomSheetShell extends StatelessWidget {
  final String title;
  final Widget content;
  const CustomBottomSheetShell({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.cardBorderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.black20w600TextStyle),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close, color: AppColors.greyColor),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          content,
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
