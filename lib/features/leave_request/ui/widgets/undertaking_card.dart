import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

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
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            activeColor: context.colorScheme.primary,
            onChanged: isEnabled ? onChanged : null,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I solemnly declare that all statements provided above are true, and I assume full administrative and legal responsibility for their accuracy.",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
                const Divider(height: 12),
                Text(
                  "أقر وأتعهد بصحة البيانات المدونة أعلاه، وأتحمل المسؤولية الإدارية والقانونية الكاملة في حال عدم صحتها.",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
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
