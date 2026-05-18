import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_text_styles.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody:
          false, // This is important! It allows the content to be centered
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 64.sp, color: Colors.grey),
            SizedBox(height: 16.h),
            //TODO: localize this message
            Text(
              "No requests found for this status",
              style: AppTextStyles.grey18w400TextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
