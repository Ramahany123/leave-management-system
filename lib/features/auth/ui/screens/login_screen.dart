import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/auth/data/models/login_body_model.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/language/locale_keys.g.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    GoRouter.of(
                      context,
                    ).pushReplacement(AppRoutes.employeeDashboardScreen);
                  } else if (state is AuthNeedActivation) {
                    GoRouter.of(context).pushNamed(AppRoutes.onboardingScreen);
                  } else if (state is AuthError) {
                    showAnimatedSnakDialogue(
                      context,
                      type: AnimatedSnackBarType.error,
                      message: state.failure.message,
                    );
                  }
                },
                child: Form(
                  key: _formKey,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 48.h),
                          Image.asset(
                            AppImages.universityLogo,
                            height: 120.sp,
                            width: 120.sp,
                          ),
                          SizedBox(height: 35.h),
                          Text(
                            LocaleKeys.login_title.tr(),
                            style: AppTextStyles.black24w600TextStyle,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            LocaleKeys.login_subtitle.tr(),
                            style: AppTextStyles.grey18w400TextStyle,
                          ),
                          SizedBox(height: 40.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.login_email_label.tr(),
                              style: AppTextStyles.black16w500TextStyle,
                            ),
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: "email@university.edu",
                            validator: AppValidators.validateEmail,
                            textInputType: TextInputType.emailAddress,
                            isEnabled: state is! AuthLoading,
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.login_password_label.tr(),
                              style: AppTextStyles.black16w500TextStyle,
                            ),
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Enter at least 8 characters",
                            isPassword: true,
                            validator: AppValidators.validatePassword,
                            isEnabled: state is! AuthLoading,
                          ),
                          SizedBox(height: 32.h),
                          PrimaryButtonWidget(
                            isLoading: state is AuthLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                  LoginBodyModel(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: LocaleKeys.login_submit_button.tr(),
                          ),

                          SizedBox(height: 24.h),
                          Text(
                            LocaleKeys.login_onboarding_message.tr(),
                            style: AppTextStyles.grey12w500TextStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
