import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

import '../../../../core/constants/leave_type_options.dart';
import '../../../../core/utils/app_validators.dart';

/// Approval workflow steps.
///
/// Editable while creating — the update API has no `workflow` field, so in
/// edit mode ([isReadOnly]) the steps render as a read-only summary.
class LeaveTypeWorkflowSection extends StatelessWidget {
  final List<String?> steps;
  final bool isReadOnly;
  final bool isDisabled;
  final void Function(int index, String? role) onStepChanged;
  final VoidCallback onAddStep;
  final ValueChanged<int> onRemoveStep;

  const LeaveTypeWorkflowSection({
    super.key,
    required this.steps,
    required this.isReadOnly,
    required this.isDisabled,
    required this.onStepChanged,
    required this.onAddStep,
    required this.onRemoveStep,
  });

  @override
  Widget build(BuildContext context) {
    if (isReadOnly) return _buildReadOnly(context);
    return _buildEditable(context);
  }

  Widget _buildStepNumber(BuildContext context, int index) {
    return Container(
      width: 28.w,
      height: 28.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        "${index + 1}",
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildEditable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              _buildStepNumber(context, i),
              SizedBox(width: 10.w),
              Expanded(
                child: DropdownButtonFormField<String>(
                  hint: const Text("Select approver"),
                  initialValue: steps[i],
                  validator: AppValidators.validateRequired,
                  items: LeaveTypeOptions.approverRoles
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(LeaveTypeOptions.displayLabel(role)),
                        ),
                      )
                      .toList(),
                  onChanged: isDisabled
                      ? null
                      : (role) => onStepChanged(i, role),
                ),
              ),
              if (steps.length > 1) ...[
                SizedBox(width: 4.w),
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline_rounded,
                    color: context.colorScheme.error,
                    size: 22.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: isDisabled ? null : () => onRemoveStep(i),
                ),
              ],
            ],
          ),
          if (i != steps.length - 1) SizedBox(height: 12.h),
        ],
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isDisabled ? null : onAddStep,
            icon: const Icon(Icons.add),
            label: const Text("Add Approval Step"),
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnly(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                _buildStepNumber(context, i),
                SizedBox(width: 10.w),
                Text(
                  steps[i] == null
                      ? "—"
                      : LeaveTypeOptions.displayLabel(steps[i]!),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 14.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                "Approval workflow can't be edited after creation.",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
