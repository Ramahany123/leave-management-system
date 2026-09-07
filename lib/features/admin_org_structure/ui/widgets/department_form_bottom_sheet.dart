import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_departements_model.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/colleges_cubit.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/department_form_cubit.dart';

class DepartmentFormBottomSheet extends StatefulWidget {
  final Department? department;

  const DepartmentFormBottomSheet({super.key, this.department});

  @override
  State<DepartmentFormBottomSheet> createState() =>
      _DepartmentFormBottomSheetState();
}

class _DepartmentFormBottomSheetState extends State<DepartmentFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _headIdController;
  late int? _selectedCollegeId;

  bool get isEditMode => widget.department != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.department?.departmentName ?? "",
    );
    _headIdController = TextEditingController(
      text: widget.department?.headUserId?.toString() ?? "",
    );
    _selectedCollegeId = widget.department?.collegeId;
  }

  @override
  void dispose() {
    _headIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final headId = int.tryParse(_headIdController.text.trim());
    final cubit = context.read<DepartmentFormCubit>();
    if (isEditMode) {
      cubit.updateDepartment(
        widget.department!.departmentId,
        deptName: name,
        collegeId: _selectedCollegeId,
        headId: headId,
      );
    } else {
      cubit.createDepartment(
        deptName: name,
        collegeId: _selectedCollegeId!,
        headId: headId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartmentFormCubit, DepartmentFormState>(
      listener: (context, state) {
        if (state is DepartmentFormSuccess) {
          context.pop(true);
          showAnimatedSnakDialogue(
            context,
            message: isEditMode
                ? "Department Updated Successfully"
                : "Department Created Successfully",
          );
        } else if (state is DepartmentFormError) {
          showAnimatedSnakDialogue(
            context,
            message: state.failure.message,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is DepartmentFormLoading;
        return PopScope(
          canPop: !isLoading,
          child: CustomBottomSheetShell(
            title: isEditMode ? "Edit Department" : "Create Department",
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
                    // ==================== 1. DEPARTMENT NAME ====================
                    Text(
                      "Department Name",
                      style: context.textTheme.titleSmall,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter department name...",
                      isEnabled: !isLoading,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Department name is required";
                        }
                        if (val.trim().length < 3) {
                          return "Must be at least 3 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // ==================== 2. PARENT COLLEGE DROPDOWN ====================
                    Text("Parent College", style: context.textTheme.titleSmall),
                    SizedBox(height: 8.h),
                    BlocBuilder<CollegesCubit, CollegesState>(
                      builder: (context, state) {
                        final colleges = state is CollegesSuccess
                            ? state.colleges
                            : <CollegeModel>[];

                        return DropdownButtonFormField<int>(
                          initialValue: _selectedCollegeId,
                          decoration: const InputDecoration(
                            hintText: "Select parent college...",
                          ),
                          items: colleges.map((c) {
                            return DropdownMenuItem<int>(
                              value: c.collegeId,
                              child: Text(
                                c.collegeName,
                                style: context.textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                          onChanged: isLoading
                              ? null
                              : (val) {
                                  setState(() => _selectedCollegeId = val);
                                },
                          validator: (val) => val == null
                              ? "Please select a parent college"
                              : null,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),

                    // ==================== 3. HEAD OF DEPARTMENT ID ====================
                    Text(
                      "Head of Department User ID (Optional)",
                      style: context.textTheme.titleSmall,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _headIdController,
                      hintText: "Enter assigned Head's user ID...",
                      textInputType: TextInputType.number,
                      isEnabled: !isLoading,
                    ),
                    SizedBox(height: 24.h),

                    // ==================== 4. SUBMIT BUTTON ====================
                    PrimaryButtonWidget(
                      isLoading: isLoading,
                      onPressed: _submitForm,
                      child: Text(
                        isEditMode ? "Save Changes" : "Create Department",
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
