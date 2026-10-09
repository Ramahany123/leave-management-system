import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';

/// One editable row of the required-documents list.
///
/// [documentRequirementId] != null means the row already exists on the
/// backend — the update payload needs it to add / update / remove documents.
class DocumentRowData {
  final TextEditingController nameController;
  final int? documentRequirementId;
  bool isMandatory;

  DocumentRowData({
    required this.nameController,
    this.documentRequirementId,
    this.isMandatory = false,
  });

  void dispose() => nameController.dispose();
}

class LeaveTypeDocumentsSection extends StatelessWidget {
  final List<DocumentRowData> rows;
  final bool isDisabled;
  final VoidCallback onAddRow;
  final ValueChanged<int> onRemoveRow;
  final ValueChanged<int> onMandatoryChanged;

  const LeaveTypeDocumentsSection({
    super.key,
    required this.rows,
    required this.isDisabled,
    required this.onAddRow,
    required this.onRemoveRow,
    required this.onMandatoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rows.isEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              "No required documents. Add one if employees must attach files "
              "when requesting this leave.",
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        for (int i = 0; i < rows.length; i++) ...[
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Document ${i + 1}",
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: context.colorScheme.error,
                        size: 20.sp,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: isDisabled ? null : () => onRemoveRow(i),
                    ),
                  ],
                ),
                CustomTextField(
                  hintText: "e.g. Official certificate",
                  controller: rows[i].nameController,
                  validator: AppValidators.validateField,
                  isEnabled: !isDisabled,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Mandatory", style: context.textTheme.bodyMedium),
                  subtitle: Text(
                    rows[i].isMandatory
                        ? "Employees must attach this file"
                        : "Employees may attach this file optionally",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  value: rows[i].isMandatory,
                  onChanged: isDisabled ? null : (_) => onMandatoryChanged(i),
                  activeThumbColor: context.colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isDisabled ? null : onAddRow,
            icon: const Icon(Icons.add),
            label: const Text("Add Required Document"),
          ),
        ),
      ],
    );
  }
}
