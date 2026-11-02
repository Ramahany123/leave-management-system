import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
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
  String? _status;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _commentsController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  String _statusLabel(String status) {
    return switch (status) {
      RequestStatues.approved => LocaleKeys.admin_reports_approved.tr(),
      RequestStatues.rejected => LocaleKeys.admin_reports_rejected.tr(),
      RequestStatues.cancelled => LocaleKeys.admin_reports_cancelled.tr(),
      _ => status,
    };
  }

  Future<void> _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final status = _status;
    if (status == null) return;
    final cubit = context.read<OverrideReportCubit>();
    await cubit.overrideStatus(
      id: widget.leaveRequest.requestId,
      status: status,
      comments: _commentsController.text,
    );
    if (!mounted) return;
    if (cubit.state is OverrideReportSuccess) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverrideReportCubit, OverrideReportState>(
      builder: (context, state) {
        final isLoading = state is OverrideReportLoading;
        return PopScope(
          canPop: !isLoading,
          child: BlocListener<OverrideReportCubit, OverrideReportState>(
            listenWhen: (previous, current) => current is OverrideReportError,
            listener: (context, state) {
              showAnimatedSnakDialogue(
                context,
                type: AnimatedSnackBarType.error,
                message: (state as OverrideReportError).failure.message,
              );
            },
            child: AlertDialog(
              title: Text(
                LocaleKeys.admin_reports_override_title.tr(),
                style: context.textTheme.headlineMedium,
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        validator: AppValidators.validateField,
                        hint: Text(
                          LocaleKeys.admin_reports_override_status_hint.tr(),
                        ),
                        items: RequestStatues.overrideStatuses
                            .map(
                              (status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(_statusLabel(status)),
                              ),
                            )
                            .toList(),
                        onChanged: isLoading
                            ? null
                            : (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _status = newValue;
                                  });
                                }
                              },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        hintText: LocaleKeys
                            .admin_reports_override_comments_hint
                            .tr(),
                        controller: _commentsController,
                        isEnabled: !isLoading,
                        validator: (value) =>
                            AppValidators.validateMinLength(value, 5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        LocaleKeys.admin_reports_override_warning.tr(),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  spacing: 50.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: isLoading ? null : () => context.pop(false),
                      child: Text(
                        LocaleKeys.dialogs_cancel.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: PrimaryButtonWidget(
                        isLoading: isLoading,
                        height: 50.h,
                        backgroundColor: context.colorScheme.errorContainer,
                        onPressed: () async {
                          await _onSubmit();
                        },
                        child: Text(
                          LocaleKeys.admin_reports_override_confirm.tr(),
                          style: context.textTheme.titleMedium!.copyWith(
                            color: context.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
