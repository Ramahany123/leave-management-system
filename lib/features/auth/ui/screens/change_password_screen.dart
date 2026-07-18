import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/auth/data/models/change_password_body_model.dart';

import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button_widget.dart';
import '../../logic/cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //TODO: localize text
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password", style: context.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordError) {
                      showAnimatedSnakDialogue(
                        context,
                        message: state.failure.message,
                        type: AnimatedSnackBarType.error,
                      );
                    } else if (state is ChangePasswordSuccess) {
                      showAnimatedSnakDialogue(context, message: state.message);
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading = state is ChangePasswordLoading;
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(context, "Current Password"),
                          CustomTextField(
                            controller: _currentPasswordController,
                            hintText: "Enter current password",
                            isPassword: true,
                            validator: (value) =>
                                AppValidators.validatePassword(value),
                            isEnabled: !isLoading,
                          ),
                          SizedBox(height: 24.h),

                          _buildLabel(context, "New Password"),
                          CustomTextField(
                            controller: _newPasswordController,
                            hintText: "Enter new password",
                            isPassword: true,
                            validator: (value) =>
                                AppValidators.validatePassword(value),
                            isEnabled: !isLoading,
                          ),
                          SizedBox(height: 24.h),

                          _buildLabel(context, "Confirm New Password"),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: "Repeat new password",
                            isPassword: true,
                            validator: (value) =>
                                AppValidators.validateConfirmPassword(
                                  value,
                                  _newPasswordController.text,
                                ),
                            isEnabled: !isLoading,
                          ),

                          if (MediaQuery.of(context).viewInsets.bottom == 0)
                            const Spacer()
                          else
                            SizedBox(height: 24.h),

                          PrimaryButtonWidget(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ChangePasswordBodyModel changePasswordBody =
                                    ChangePasswordBodyModel(
                                      oldPassword:
                                          _currentPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                      confirmNewPassword:
                                          _confirmPasswordController.text,
                                    );
                                context
                                    .read<ChangePasswordCubit>()
                                    .changePassword(changePasswordBody);
                              }
                            },
                            isLoading: isLoading,
                            child: Text(
                              "Update Password",
                              style: context.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(label, style: context.textTheme.titleSmall),
      ),
    );
  }
}
