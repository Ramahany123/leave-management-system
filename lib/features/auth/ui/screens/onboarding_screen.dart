import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_validators.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/auth/data/models/activation_body_model.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthActivationSuccess) {
                    //TODO: use localization for this text
                    showAnimatedSnakDialogue(
                      context,
                      message: "Account is Activated",
                      type: AnimatedSnackBarType.success,
                    );
                  } else if (state is AuthActivationError) {
                    showAnimatedSnakDialogue(
                      context,
                      message: state.failure.message,
                      type: AnimatedSnackBarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  final bool isLoading = state is AuthActivationLoading;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.onboarding_title.tr(),
                              style: AppTextStyles.grey12w500TextStyle,
                            ),
                            Text(
                              LocaleKeys.onboarding_step.tr(),
                              style: AppTextStyles.grey12w500TextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        LinearProgressIndicator(
                          value: 1,
                          backgroundColor: AppColors.greyColor.withValues(
                            alpha: 0.2,
                          ),
                          color: AppColors.primaryBlue,
                          minHeight: 8.h,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        SizedBox(height: 32.h),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            LocaleKeys.onboarding_header.tr(),
                            style: AppTextStyles.black24w600TextStyle,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocaleKeys.onboarding_sub_header.tr(),
                          style: AppTextStyles.grey18w400TextStyle,
                        ),
                        SizedBox(height: 32.h),
                        Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.onboarding_phone_label.tr(),
                                  style: AppTextStyles.black16w500TextStyle,
                                ),
                                CustomTextField(
                                  isEnabled: !isLoading,
                                  validator: AppValidators.validateField,
                                  controller: phoneController,
                                  hintText: "01039476478",
                                  textInputType: TextInputType.number,
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  LocaleKeys.onboarding_new_password_label.tr(),
                                  style: AppTextStyles.black16w500TextStyle,
                                ),
                                CustomTextField(
                                  isEnabled: !isLoading,
                                  controller: passwordController,
                                  isPassword: true,
                                  validator: AppValidators.validatePassword,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  LocaleKeys.onboarding_confirm_password_label
                                      .tr(),
                                  style: AppTextStyles.black16w500TextStyle,
                                ),
                                CustomTextField(
                                  isEnabled: !isLoading,
                                  controller: confirmPasswordController,
                                  isPassword: true,
                                  validator: (value) =>
                                      AppValidators.validateConfirmPassword(
                                        value,
                                        passwordController.text,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(height: 24.h),
                        PrimaryButtonWidget(
                          isLoading: isLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ActivationBodyModel activationBody =
                                  ActivationBodyModel(
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  );
                              context.read<AuthCubit>().activateUser(
                                activationBody,
                              );
                            }
                          },
                          text: LocaleKeys.onboarding_submit_button.tr(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
