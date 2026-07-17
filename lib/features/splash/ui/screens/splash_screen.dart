import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: sl<AuthRepo>(),
          builder: (context, _) {
            final authRepo = sl<AuthRepo>();
            final initialFailure = authRepo.initialAuthFailure;
            if (initialFailure != null) {
              return Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                  child: GeneralErrorWidget(
                    message: initialFailure.message,
                    onRetry: () => authRepo.checkInitialAuthStatus(),
                  ),
                ),
              );
            }
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.universityLogo,
                    height: 180.sp,
                    width: 180.sp,
                  ),
                  SizedBox(height: 25.h),
                  Lottie.asset(AppImages.loadingLottie),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
