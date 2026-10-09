import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

import '../../../../core/constants/leave_type_options.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/form_label_widget.dart';

class LeaveTypeBalanceSection extends StatelessWidget {
  final String? selectedBalanceType;
  final ValueChanged<String?> onBalanceTypeChanged;
  final bool showFixedBalance;
  final TextEditingController fixedBalanceController;
  final String? selectedCalculationMethod;
  final ValueChanged<String?> onCalculationMethodChanged;
  final bool isPaid;
  final ValueChanged<bool> onIsPaidChanged;
  final bool deductFromBalance;
  final ValueChanged<bool> onDeductFromBalanceChanged;
  final bool isDisabled;

  const LeaveTypeBalanceSection({
    super.key,
    required this.selectedBalanceType,
    required this.onBalanceTypeChanged,
    required this.showFixedBalance,
    required this.fixedBalanceController,
    required this.selectedCalculationMethod,
    required this.onCalculationMethodChanged,
    required this.isPaid,
    required this.onIsPaidChanged,
    required this.deductFromBalance,
    required this.onDeductFromBalanceChanged,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelWidget(label: "Balance Type", isRequired: true),
        DropdownButtonFormField<String>(
          hint: const Text("Select balance type"),
          initialValue: selectedBalanceType,
          validator: AppValidators.validateRequired,
          items: LeaveTypeOptions.balanceTypes
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(LeaveTypeOptions.displayLabel(item)),
                ),
              )
              .toList(),
          onChanged: isDisabled ? null : onBalanceTypeChanged,
        ),
        if (showFixedBalance) ...[
          SizedBox(height: 16.h),
          const FormLabelWidget(
            label: "Fixed Balance (days)",
            isRequired: true,
          ),
          CustomTextField(
            hintText: "e.g. 30",
            controller: fixedBalanceController,
            validator: AppValidators.validateRequiredInt,
            isEnabled: !isDisabled,
            textInputType: TextInputType.number,
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
        SizedBox(height: 16.h),
        const FormLabelWidget(label: "Calculation Method", isRequired: true),
        DropdownButtonFormField<String>(
          hint: const Text("Select calculation method"),
          initialValue: selectedCalculationMethod,
          validator: AppValidators.validateRequired,
          items: LeaveTypeOptions.calculationMethods
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: isDisabled ? null : onCalculationMethodChanged,
        ),
        SizedBox(height: 16.h),
        _buildSwitchTile(
          context,
          title: "Paid Leave",
          subtitle: isPaid
              ? "Employees continue to receive their salary"
              : "Leave days are unpaid",
          value: isPaid,
          onChanged: onIsPaidChanged,
        ),
        SizedBox(height: 12.h),
        _buildSwitchTile(
          context,
          title: "Deduct From Balance",
          subtitle: deductFromBalance
              ? "Days are subtracted from the employee's balance"
              : "Employee's balance is not affected",
          value: deductFromBalance,
          onChanged: onDeductFromBalanceChanged,
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
