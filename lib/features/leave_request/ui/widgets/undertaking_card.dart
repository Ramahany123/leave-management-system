import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';

class UndertakingCard extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final bool isEnabled;

  const UndertakingCard({
    super.key,
    required this.value,
    required this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.cardBorderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            activeColor: AppColors.primaryBlue,
            onChanged: isEnabled ? onChanged : null,
          ),
          SizedBox(width: 8.w),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // English Declaration
                Text(
                  "I solemnly declare that all statements provided above are true, and I assume full administrative and legal responsibility for their accuracy.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    height: 1.3,
                  ),
                ),
                Divider(height: 12),
                // Arabic Declaration (Egyptian Undertaking)
                Text(
                  "أقر وأتعهد بصحة البيانات المدونة أعلاه، وأتحمل المسؤولية الإدارية والقانونية الكاملة في حال عدم صحتها.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    height: 1.3,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
