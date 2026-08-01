import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/app_validators.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../../../core/widgets/primary_button_widget.dart';

class CouncilSessionDialog extends StatefulWidget {
  final void Function(
    String sessionNumber,
    DateTime sessionDate,
    String? comments,
  )
  onConfirm;
  const CouncilSessionDialog({super.key, required this.onConfirm});

  @override
  State<CouncilSessionDialog> createState() => _CouncilSessionDialogState();
}

class _CouncilSessionDialogState extends State<CouncilSessionDialog> {
  DateTime? _selectedDate;
  late final TextEditingController _sessionNumberController;
  late final TextEditingController _dateController;
  late final TextEditingController _commentsController;
  late final GlobalKey<FormState> _formKey;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await DatePickerHelper.pickDate(
      context,
      initialDate: _selectedDate ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.toIso8601String().split("T").first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _sessionNumberController = TextEditingController();
    _dateController = TextEditingController();
    _commentsController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _sessionNumberController.dispose();
    _dateController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Council Session", style: context.textTheme.headlineMedium),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: _sessionNumberController,
              hintText: "Enter Session Number",
              validator: AppValidators.validateField,
            ),
            SizedBox(height: 14.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: CustomTextField(
                  controller: _dateController,
                  hintText: "Select Session Date (YYYY-MM-DD)",
                  validator: AppValidators.validateField,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              hintText: "Enter Comments (optional)",
              controller: _commentsController,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text("Cancel", style: context.textTheme.bodyMedium),
        ),
        PrimaryButtonWidget(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.pop();
              widget.onConfirm(
                _sessionNumberController.text.trim(),
                _selectedDate!,
                _commentsController.text.trim(),
              );
            }
          },
          child: Text(
            "Confirm",
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
