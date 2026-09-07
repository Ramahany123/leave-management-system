import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/admin_org_structure/data/models/all_colleges_model.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/college_form_cubit.dart';

import '../../../../core/theme/theme_context_extension.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CollegeFormBottomSheet extends StatefulWidget {
  final CollegeModel? college;
  const CollegeFormBottomSheet({super.key, this.college});

  @override
  State<CollegeFormBottomSheet> createState() => _CollegeFormBottomSheetState();
}

class _CollegeFormBottomSheetState extends State<CollegeFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _deanIdController;
  bool get isEditMode => widget.college != null;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.college?.collegeName ?? "",
    );
    _deanIdController = TextEditingController(
      text: widget.college?.deanId?.toString() ?? "",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _deanIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final deanId = int.tryParse(_deanIdController.text.trim());
    final cubit = context.read<CollegeFormCubit>();

    if (isEditMode) {
      cubit.updateCollege(
        widget.college!.collegeId,
        deanId: deanId,
        name: name,
      );
    } else {
      cubit.createCollege(name, deanId: deanId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollegeFormCubit, CollegeFormState>(
      listener: (context, state) {
        if (state is CollegeFormSuccess) {
          context.pop(true);
          showAnimatedSnakDialogue(
            context,
            message: isEditMode
                ? "College updated successfully"
                : "College created successfully",
          );
        } else if (state is CollegeFormError) {
          showAnimatedSnakDialogue(
            context,
            message: state.failure.message,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CollegeFormLoading;
        return CustomBottomSheetShell(
          title: isEditMode ? "Edit College" : "Create College",
          content: PopScope(
            canPop: !isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("College Name", style: context.textTheme.titleSmall),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter college name...",
                      isEnabled: !isLoading,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "College name is required";
                        }
                        if (val.trim().length < 3) {
                          return "Must be at least 3 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // 2. Dean User ID (Optional)
                    Text(
                      "Dean User ID (Optional)",
                      style: context.textTheme.titleSmall,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _deanIdController,
                      hintText: "Enter assigned Dean's user ID...",
                      textInputType: TextInputType.number,
                      isEnabled: !isLoading,
                    ),
                    SizedBox(height: 24.h),
                    PrimaryButtonWidget(
                      isLoading: isLoading,
                      onPressed: _submitForm,
                      child: Text(
                        isEditMode ? "Save Changes" : "Create College",
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
