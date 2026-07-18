import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_body_model.dart';
import 'package:leave_management_system/features/profile/logic/cubit/update_contact_cubit.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button_widget.dart';

class UpdateContactScreen extends StatefulWidget {
  const UpdateContactScreen({super.key});

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact", style: context.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: BlocConsumer<UpdateContactCubit, UpdateContactState>(
                  listener: (context, state) {
                    if (state is UpdateContactError) {
                      showAnimatedSnakDialogue(
                        context,
                        message: state.failure.message,
                        type: AnimatedSnackBarType.error,
                      );
                    } else if (state is UpdateContactSuccess) {
                      showAnimatedSnakDialogue(
                        context,
                        message: "Phone number changed successfully",
                      );
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading = state is UpdateContactLoading;
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(context, "Phone"),
                          CustomTextField(
                            controller: _phoneController,
                            hintText: "Enter new phone number",
                            validator: (value) =>
                                AppValidators.validateField(value),
                            isEnabled: !isLoading,
                          ),
                          SizedBox(height: 24.h),
                          _buildLabel(context, "Password"),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Enter your password",
                            isPassword: true,
                            validator: (value) =>
                                AppValidators.validatePassword(value),
                            isEnabled: !isLoading,
                          ),

                          SizedBox(height: 24.h),

                          if (MediaQuery.of(context).viewInsets.bottom == 0)
                            const Spacer()
                          else
                            SizedBox(height: 24.h),

                          PrimaryButtonWidget(
                            isLoading: isLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UpdateContactBodyModel updateContactBody =
                                    UpdateContactBodyModel(
                                      phone: _phoneController.text,
                                      password: _passwordController.text,
                                    );
                                context
                                    .read<UpdateContactCubit>()
                                    .updateContact(updateContactBody);
                              }
                            },
                            child: Text(
                              "Save",
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
