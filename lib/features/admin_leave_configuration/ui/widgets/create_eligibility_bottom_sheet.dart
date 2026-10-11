import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/form_label_widget.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/admin_leave_configuration/constants/eligibility_options.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/create_eligibility_rule_request_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/eligibility_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_cubit.dart';

class CreateEligibilityBottomSheet extends StatefulWidget {
  final int? preselectedLeaveTypeId;

  const CreateEligibilityBottomSheet({super.key, this.preselectedLeaveTypeId});

  @override
  State<CreateEligibilityBottomSheet> createState() =>
      _CreateEligibilityBottomSheetState();
}

class _CreateEligibilityBottomSheetState
    extends State<CreateEligibilityBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedLeaveTypeId;
  String? _selectedUserType;

  @override
  void initState() {
    super.initState();
    _selectedLeaveTypeId = widget.preselectedLeaveTypeId;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    context.read<EligibilityCubit>().createEligibilityRule(
      requestBody: CreateEligibilityRuleRequestModel(
        leaveTypeId: _selectedLeaveTypeId!,
        eligibleUserType: _selectedUserType!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EligibilityCubit, EligibilityState>(
      listenWhen: (prev, curr) =>
          (!prev.createSuccess && curr.createSuccess) ||
          prev.createRuleFailure != curr.createRuleFailure,
      listener: (context, state) {
        if (state.createSuccess) {
          context.pop(true);
        } else if (state.createRuleFailure != null) {
          showAnimatedSnakDialogue(
            context,
            message: state.createRuleFailure!.message,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state.isCreating;
        return PopScope(
          canPop: !isLoading,
          child: CustomBottomSheetShell(
            title: "Add Eligibility Rule",
            content: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormLabelWidget(
                      label: "Leave Type",
                      isRequired: true,
                    ),
                    BlocBuilder<LeaveTypeCubit, LeaveTypeState>(
                      builder: (context, leaveTypeState) {
                        final leaveTypes = leaveTypeState.leaveTypesList;
                        return DropdownButtonFormField<int>(
                          initialValue: leaveTypes.any(
                            (leaveType) =>
                                leaveType.typeId == _selectedLeaveTypeId,
                          )
                              ? _selectedLeaveTypeId
                              : null,
                          hint: const Text("Select leave type..."),
                          items: leaveTypes
                              .map(
                                (leaveType) => DropdownMenuItem<int>(
                                  value: leaveType.typeId,
                                  child: Text(leaveType.typeName),
                                ),
                              )
                              .toList(),
                          onChanged: (isLoading || leaveTypes.isEmpty)
                              ? null
                              : (val) =>
                                  setState(() => _selectedLeaveTypeId = val),
                          validator: (val) =>
                              val == null ? "Please select a leave type" : null,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    const FormLabelWidget(
                      label: "Eligible User Type",
                      isRequired: true,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedUserType,
                      hint: const Text("Select user type..."),
                      items: EligibilityOptions.withCurrent(
                        EligibilityOptions.userTypes,
                        _selectedUserType,
                      )
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: isLoading
                          ? null
                          : (val) => setState(() => _selectedUserType = val),
                      validator: (val) =>
                          val == null ? "Please select a user type" : null,
                    ),
                    SizedBox(height: 24.h),
                    PrimaryButtonWidget(
                      isLoading: isLoading,
                      onPressed: _submitForm,
                      child: Text(
                        "Create Rule",
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
