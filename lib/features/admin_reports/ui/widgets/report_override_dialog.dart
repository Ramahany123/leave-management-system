import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/utils/app_validators.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';
import 'package:leave_management_system/features/admin_reports/logic/cubit/override_report_cubit.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../../../core/widgets/primary_button_widget.dart';

class ReportOverrideDialog extends StatefulWidget {
  final ReportLeaveRequest leaveRequest;
  const ReportOverrideDialog({super.key, required this.leaveRequest});

  @override
  State<ReportOverrideDialog> createState() => _ReportOverrideDialogState();
}

class _ReportOverrideDialogState extends State<ReportOverrideDialog> {
  late final TextEditingController _commentsController;
  late String _status;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _commentsController = TextEditingController();
    _status = widget.leaveRequest.status;
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final cubit = context.read<OverrideReportCubit>();
      await cubit.overrideStatus(
        id: widget.leaveRequest.requestId,
        status: _status,
        comments: _commentsController.text,
      );
      if (!mounted) return;
      if (cubit.state is OverrideReportSuccess) {
        context.pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Override Leave Request Status",
        style: context.textTheme.headlineMedium,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              validator: AppValidators.validateField,
              hint: Text("Select Status"),
              items: RequestStatues.overrideStatuses
                  .map(
                    (status) => DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _status = newValue;
                  });
                }
              },
            ),
            CustomTextField(
              hintText: "Enter Change Reason",
              controller: _commentsController,
              validator: AppValidators.validateField,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => context.pop(false),
              child: Text("Cancel", style: context.textTheme.bodyMedium),
            ),
            BlocBuilder<OverrideReportCubit, OverrideReportState>(
              builder: (context, state) {
                final isLoading = state is OverrideReportLoading;
                return PrimaryButtonWidget(
                  isLoading: isLoading,
                  width: 100.w,
                  height: 50.h,
                  backgroundColor: context.colorScheme.errorContainer,
                  onPressed: () async {
                    await _onSubmit();
                  },
                  child: Text(
                    "Override",
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onErrorContainer,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
