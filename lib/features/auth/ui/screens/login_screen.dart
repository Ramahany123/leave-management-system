import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/core/utils/app_validators.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 48.h),
                  Image.asset(
                    AppConstants.universityLogo,
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
                  // 3. Wrapped the email text in an Align widget
                  Align(
                    // Uses centerStart to automatically handle LTR and RTL languages
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      LocaleKeys.login_email_label.tr(),
                      style: AppTextStyles.black16w500TextStyle,
                    ),
                  ),

                  CustomTextField(
                    hintText: "email@university.edu",
                    validator: AppValidators.validateEmail,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
