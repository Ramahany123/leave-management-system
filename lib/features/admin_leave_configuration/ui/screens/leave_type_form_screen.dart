import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/core/widgets/section_header_widget.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/create_leave_type_request_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/required_document_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/update_leave_type_request_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/logic/cubit/leave_type_form_cubit.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_basic_info_section.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_balance_section.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_documents_section.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_limits_section.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_requirements_section.dart';
import 'package:leave_management_system/features/admin_leave_configuration/ui/widgets/leave_type_workflow_section.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../data/models/work_flow_step_model.dart';

class LeaveTypeFormScreen extends StatefulWidget {
  final LeaveType? leaveType;
  const LeaveTypeFormScreen({super.key, this.leaveType});

  @override
  State<LeaveTypeFormScreen> createState() => _LeaveTypeFormScreenState();
}

class _LeaveTypeFormScreenState extends State<LeaveTypeFormScreen> {
  bool get isEditingMode => widget.leaveType != null;

  final _formKey = GlobalKey<FormState>();

  // Text
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _descriptionController;
  // Numbers as text — parsed at save time
  late final TextEditingController _fixedBalanceController;
  late final TextEditingController _yearsOfServiceController;
  late final TextEditingController _lifetimeLimitController;
  late final TextEditingController _maxDaysPerRequestController;
  late final TextEditingController _minDaysDurationController;
  late final TextEditingController _requiredGapDaysController;

  // Dropdowns (backend enums)
  String? _selectedBalanceType;
  String? _selectedCalculationMethod;
  String? _selectedGenderPolicy;

  // Switches
  late bool _isPaid;
  late bool _deductFromBalance;
  late bool _requiresDocument;
  late bool _requiresDelegate;

  // Workflow (editable only in create mode)
  late List<String?> _workflowSteps;

  // Required documents
  late List<DocumentRowData> _documentRows;

  bool get _showFixedBalance => _selectedBalanceType == 'fixed';

  void _initializeForm() {
    final leaveType = widget.leaveType;

    _nameController = TextEditingController(text: leaveType?.typeName ?? '');
    _categoryController = TextEditingController(
      text: leaveType?.category ?? '',
    );
    _descriptionController = TextEditingController(
      text: leaveType?.description ?? '',
    );
    _fixedBalanceController = TextEditingController(
      text: leaveType != null && leaveType.balanceType == 'fixed'
          ? leaveType.fixedBalance?.toString() ?? ''
          : '',
    );
    _yearsOfServiceController = TextEditingController(
      text: leaveType?.yearsOfServiceRequired.toString() ?? '',
    );
    _lifetimeLimitController = TextEditingController(
      text: leaveType?.lifetimeLimit?.toString() ?? '',
    );
    _maxDaysPerRequestController = TextEditingController(
      text: leaveType?.maxDaysPerRequest?.toString() ?? '',
    );
    _minDaysDurationController = TextEditingController(
      text: leaveType?.minDaysDuration.toString() ?? '',
    );
    _requiredGapDaysController = TextEditingController(
      text: leaveType?.requiredGapDays.toString() ?? '',
    );

    _selectedBalanceType = leaveType?.balanceType;
    _selectedCalculationMethod = leaveType?.calculationMethod;
    _selectedGenderPolicy = leaveType?.genderPolicy ?? 'All';

    _isPaid = leaveType?.isPaid ?? false;
    _deductFromBalance = leaveType?.deductFromBalance ?? false;
    _requiresDocument = leaveType?.requiresDocument ?? false;
    _requiresDelegate = leaveType?.requiresDelegate ?? false;

    _workflowSteps = leaveType == null
        ? <String?>[null]
        : leaveType.workflow.map((step) => step.approverRole).toList();

    _documentRows =
        leaveType?.requiredDocuments
            .map(
              (doc) => DocumentRowData(
                nameController: TextEditingController(text: doc.documentName),
                documentRequirementId: doc.documentRequirementId,
                isMandatory: doc.isMandatory,
              ),
            )
            .toList() ??
        <DocumentRowData>[];
  }

  // ── Workflow handlers ──────────────────────────────────────────
  void _onStepChanged(int index, String? role) {
    setState(() => _workflowSteps[index] = role);
  }

  void _addStep() {
    setState(() => _workflowSteps.add(null));
  }

  void _removeStep(int index) {
    setState(() => _workflowSteps.removeAt(index));
  }

  // ── Document handlers ──────────────────────────────────────────
  void _addDocRow() {
    setState(() {
      _documentRows.add(
        DocumentRowData(nameController: TextEditingController()),
      );
    });
  }

  void _removeDocRow(int index) {
    setState(() {
      _documentRows[index].dispose();
      _documentRows.removeAt(index);
    });
  }

  void _onDocMandatoryChanged(int index) {
    setState(() {
      _documentRows[index].isMandatory = !_documentRows[index].isMandatory;
    });
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;

    final typeName = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final description = _descriptionController.text.trim();

    if (!isEditingMode) {
      final request = CreateLeaveTypeRequestModel(
        typeName: typeName,
        category: category.isEmpty ? null : category,
        balanceType: _selectedBalanceType!,
        fixedBalance: _showFixedBalance
            ? int.parse(_fixedBalanceController.text.trim())
            : null,
        isPaid: _isPaid,
        deductFromBalance: _deductFromBalance,
        lifetimeLimit: int.tryParse(_lifetimeLimitController.text.trim()),
        yearsOfServiceRequired: int.parse(
          _yearsOfServiceController.text.trim(),
        ),
        minDaysDuration: int.parse(_minDaysDurationController.text.trim()),
        requiredGapDays: int.parse(_requiredGapDaysController.text.trim()),
        maxDaysPerRequest: int.tryParse(
          _maxDaysPerRequestController.text.trim(),
        ),
        description: description.isEmpty ? null : description,
        requiresDocument: _requiresDocument,
        requiresDelegate: _requiresDelegate,
        genderPolicy: _selectedGenderPolicy!,
        calculationMethod: _selectedCalculationMethod!,
        workflow: [
          for (var i = 0; i < _workflowSteps.length; i++)
            WorkflowStep(stepOrder: i + 1, approverRole: _workflowSteps[i]!),
        ],
        requiredDocuments: [
          for (final row in _documentRows)
            RequiredDocument(
              documentRequirementId: row.documentRequirementId,
              documentName: row.nameController.text.trim(),
              isMandatory: row.isMandatory,
            ),
        ],
      );
      context.read<LeaveTypeFormCubit>().createLeaveType(request);
    } else {
      final request = UpdateLeaveTypeRequestModel.fromChanges(
        original: widget.leaveType!,
        currentTypeName: typeName,
        currentCategory: category.isEmpty ? null : category,
        currentBalanceType: _selectedBalanceType!,
        currentFixedBalance: _showFixedBalance
            ? int.parse(_fixedBalanceController.text.trim())
            : widget.leaveType!.fixedBalance,
        currentIsPaid: _isPaid,
        currentDeductFromBalance: _deductFromBalance,
        currentLifetimeLimit: int.tryParse(
          _lifetimeLimitController.text.trim(),
        ),
        currentYearsOfServiceRequired: int.parse(
          _yearsOfServiceController.text.trim(),
        ),
        currentMinDaysDuration: int.parse(
          _minDaysDurationController.text.trim(),
        ),
        currentRequiredGapDays: int.parse(
          _requiredGapDaysController.text.trim(),
        ),
        currentMaxDaysPerRequest: int.tryParse(
          _maxDaysPerRequestController.text.trim(),
        ),
        currentDescription: description.isEmpty ? null : description,
        currentRequiresDocument: _requiresDocument,
        currentRequiresDelegate: _requiresDelegate,
        currentGenderPolicy: _selectedGenderPolicy!,
        currentCalculationMethod: _selectedCalculationMethod!,
        currentRequiredDocuments: [
          for (final row in _documentRows)
            RequiredDocument(
              documentName: row.nameController.text.trim(),
              isMandatory: row.isMandatory,
              documentRequirementId: row.documentRequirementId,
            ),
        ],
      );
      context.read<LeaveTypeFormCubit>().updateLeaveType(
        id: widget.leaveType!.typeId,
        requestBody: request,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _fixedBalanceController.dispose();
    _yearsOfServiceController.dispose();
    _lifetimeLimitController.dispose();
    _maxDaysPerRequestController.dispose();
    _minDaysDurationController.dispose();
    _requiredGapDaysController.dispose();
    for (final row in _documentRows) {
      row.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditingMode ? "Edit Leave Type" : "Add New Leave Type",
          style: context.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<LeaveTypeFormCubit, LeaveTypeFormState>(
          listener: (context, state) {
            if (state is LeaveTypeFormSuccess) {
              context.pop(true);
            } else if (state is LeaveTypeFormError) {
              showAnimatedSnakDialogue(
                context,
                message: state.failure.message,
                type: AnimatedSnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is LeaveTypeFormLoading;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeaderWidget(
                            title: "Basic Information",
                            icon: Icons.info_outline,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeBasicInfoSection(
                            nameController: _nameController,
                            categoryController: _categoryController,
                            descriptionController: _descriptionController,
                            isDisabled: isLoading,
                          ),
                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Balance & Calculation",
                            icon: Icons.account_balance_outlined,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeBalanceSection(
                            selectedBalanceType: _selectedBalanceType,
                            onBalanceTypeChanged: (newValue) {
                              setState(() => _selectedBalanceType = newValue);
                            },
                            showFixedBalance: _showFixedBalance,
                            fixedBalanceController: _fixedBalanceController,
                            selectedCalculationMethod:
                                _selectedCalculationMethod,
                            onCalculationMethodChanged: (newValue) {
                              setState(
                                () => _selectedCalculationMethod = newValue,
                              );
                            },
                            isPaid: _isPaid,
                            onIsPaidChanged: (newValue) {
                              setState(() => _isPaid = newValue);
                            },
                            deductFromBalance: _deductFromBalance,
                            onDeductFromBalanceChanged: (newValue) {
                              setState(() => _deductFromBalance = newValue);
                            },
                            isDisabled: isLoading,
                          ),
                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Limits",
                            icon: Icons.schedule_outlined,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeLimitsSection(
                            lifetimeLimitController: _lifetimeLimitController,
                            yearsOfServiceController: _yearsOfServiceController,
                            maxDaysPerRequestController:
                                _maxDaysPerRequestController,
                            minDaysDurationController:
                                _minDaysDurationController,
                            requiredGapDaysController:
                                _requiredGapDaysController,
                            selectedGenderPolicy: _selectedGenderPolicy,
                            onGenderPolicyChanged: (newValue) {
                              setState(() => _selectedGenderPolicy = newValue);
                            },
                            isDisabled: isLoading,
                          ),
                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Requirements",
                            icon: Icons.checklist_outlined,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeRequirementsSection(
                            requiresDocument: _requiresDocument,
                            onRequiresDocumentChanged: (newValue) {
                              setState(() => _requiresDocument = newValue);
                            },
                            requiresDelegate: _requiresDelegate,
                            onRequiresDelegateChanged: (newValue) {
                              setState(() => _requiresDelegate = newValue);
                            },
                            isDisabled: isLoading,
                          ),
                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Approval Workflow",
                            icon: Icons.account_tree_outlined,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeWorkflowSection(
                            steps: _workflowSteps,
                            isReadOnly: isEditingMode,
                            isDisabled: isLoading,
                            onStepChanged: _onStepChanged,
                            onAddStep: _addStep,
                            onRemoveStep: _removeStep,
                          ),
                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Required Documents",
                            icon: Icons.attach_file_outlined,
                          ),
                          SizedBox(height: 14.h),
                          LeaveTypeDocumentsSection(
                            rows: _documentRows,
                            isDisabled: isLoading,
                            onAddRow: _addDocRow,
                            onRemoveRow: _removeDocRow,
                            onMandatoryChanged: _onDocMandatoryChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Sticky action area
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButtonWidget(
                      isLoading: isLoading,
                      onPressed: _onSave,
                      child: Text(
                        isEditingMode ? "Save Changes" : "Create Leave Type",
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
