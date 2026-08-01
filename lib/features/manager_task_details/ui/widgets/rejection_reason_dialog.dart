import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/app_validators.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';

class RejectionReasonDialog extends StatefulWidget {
  final void Function(String reason) onConfirm;
  const RejectionReasonDialog({super.key, required this.onConfirm});

  @override
  State<RejectionReasonDialog> createState() => _RejectionReasonDialogState();
}

class _RejectionReasonDialogState extends State<RejectionReasonDialog> {
  late final TextEditingController _reasonController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Leave Request Rejection",
        style: context.textTheme.headlineMedium,
      ),
      content: Form(
        key: _formKey,
        child: CustomTextField(
          hintText: "Enter Rejection Reason...",
          controller: _reasonController,
          validator: AppValidators.validateField,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: Text("Cancel", style: context.textTheme.bodyMedium),
        ),
        PrimaryButtonWidget(
          backgroundColor: context.colorScheme.errorContainer,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.pop();
              widget.onConfirm(_reasonController.text.trim());
            }
          },
          child: Text(
            "Reject",
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
