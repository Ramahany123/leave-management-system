import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/eligibility_rule_model.dart';

class EligibilityGroupCard extends StatelessWidget {
  final String typeName;
  final String? category;
  final List<EligibilityRule> rules;
  final int? deletingId;
  final VoidCallback onAdd;
  final void Function(EligibilityRule rule) onDelete;

  const EligibilityGroupCard({
    super.key,
    required this.typeName,
    required this.category,
    required this.rules,
    this.deletingId,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.groups_outlined,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeName,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      category ?? "Uncategorized",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: "Add rule to $typeName",
                icon: Icon(
                  Icons.add_circle_outline,
                  color: context.colorScheme.primary,
                  size: 22.sp,
                ),
                onPressed: onAdd,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1),
          for (final rule in rules)
            _RuleRow(
              rule: rule,
              isDeleting: deletingId == rule.eligibilityId,
              onDelete: () => onDelete(rule),
            ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  final EligibilityRule rule;
  final bool isDeleting;
  final VoidCallback onDelete;

  const _RuleRow({
    required this.rule,
    required this.isDeleting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            size: 18.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              rule.eligibleUserType,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          if (isDeleting)
            SizedBox(
              width: 22.w,
              height: 22.h,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: context.colorScheme.error,
              ),
            )
          else
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: context.colorScheme.error,
                size: 20.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
