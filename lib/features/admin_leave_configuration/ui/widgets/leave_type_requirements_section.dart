import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class LeaveTypeRequirementsSection extends StatelessWidget {
  final bool requiresDocument;
  final ValueChanged<bool> onRequiresDocumentChanged;
  final bool requiresDelegate;
  final ValueChanged<bool> onRequiresDelegateChanged;
  final bool isDisabled;

  const LeaveTypeRequirementsSection({
    super.key,
    required this.requiresDocument,
    required this.onRequiresDocumentChanged,
    required this.requiresDelegate,
    required this.onRequiresDelegateChanged,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitchTile(
          context,
          title: "Requires Document",
          subtitle: requiresDocument
              ? "Employees must attach files when requesting this leave"
              : "No files required when requesting this leave",
          value: requiresDocument,
          onChanged: onRequiresDocumentChanged,
        ),
        SizedBox(height: 12.h),
        _buildSwitchTile(
          context,
          title: "Requires Delegate",
          subtitle: requiresDelegate
              ? "Employee must name someone to cover their duties"
              : "No delegate required",
          value: requiresDelegate,
          onChanged: onRequiresDelegateChanged,
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
        title: Text(title, style: context.textTheme.titleSmall),
        subtitle: Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        value: value,
        onChanged: isDisabled ? null : onChanged,
        activeThumbColor: context.colorScheme.primary,
      ),
    );
  }
}
