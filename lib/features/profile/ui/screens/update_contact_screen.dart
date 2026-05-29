import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/profile/data/models/update_contact_body_model.dart';
import 'package:leave_management_system/features/profile/logic/cubit/update_contact_cubit.dart';
import '../../../../core/styles/app_text_styles.dart';
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
        title: Text("Update Contact"),
        centerTitle: true,
      ), //TODO: localize text
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
                          _buildLabel("Phone"),
                          CustomTextField(
                            controller: _phoneController,
                            hintText: "Enter new phone number",
                            validator: (value) =>
                                AppValidators.validateField(value),
                            isEnabled: !isLoading,
                          ),
                          SizedBox(height: 24.h),
                          _buildLabel("Password"),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Enter your password",
                            isPassword: true,
                            validator: (value) =>
                                AppValidators.validatePassword(value),
                            isEnabled: !isLoading,
                          ),

                          SizedBox(height: 24.h),

                          const Spacer(), // This pushes the button to the bottom!
                          // 4. Submit Button
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
                              style: AppTextStyles.white16w600TextStyle,
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(label, style: AppTextStyles.black16w500TextStyle),
      ),
    );
  }
}
