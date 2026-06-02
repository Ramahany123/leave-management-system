import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/logic/cubit/theme_cubit.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/profile/ui/widgets/profile_card.dart';
import 'package:leave_management_system/features/profile/ui/widgets/settings_group.dart';
import 'package:leave_management_system/features/profile/ui/widgets/settings_tile.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../../logic/cubit/profile_cubit.dart';
import '../widgets/profile_screen_shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return switch (state) {
                ProfileLoading() => ProfileScreenShimmer(),
                ProfileError(failure: final f) => GeneralErrorWidget(
                  message: f.message,
                  onRetry: context.read<ProfileCubit>().getProfile,
                ),
                ProfileSuccess(user: final user) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileCard(
                      name: user.name,
                      jobTitle: user.jobTitle,
                      workPlace: user.workplace,
                    ),

                    //TODO: localize text
                    _buildSectionTitle("ACCOUNT & SECURITY"),
                    SettingsGroup(
                      children: [
                        SettingsTile(
                          title: "Personal Info",
                          icon: Icons.person_outline,
                          onTap: () {
                            AppDialogs.showPersonalInfoSheet(context, user);
                          },
                        ),
                        SettingsTile(
                          title: "Change Password",
                          icon: Icons.lock_outline,
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.changePasswordScreen);
                          },
                        ),
                        SettingsTile(
                          title: "Update Contact",
                          icon: Icons.phone_outlined,
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.updateContactScreen);
                          },
                        ),
                      ],
                    ),
                    _buildSectionTitle("PREFERENCES"),
                    SettingsGroup(
                      children: [
                        SettingsTile(
                          title: "App Language",
                          icon: Icons.language,
                          subTitle: context.locale.languageCode == "en"
                              ? "English"
                              : "العربية",
                          onTap: () {
                            AppDialogs.showLanguageSheet(context);
                          },
                        ),
                        SettingsTile(
                          title: "Dark Mode",
                          icon: Icons.language,
                          trailing: BlocBuilder<ThemeCubit, bool>(
                            builder: (context, isDark) {
                              return Switch(
                                value: isDark,
                                onChanged: (value) {
                                  context.read<ThemeCubit>().toggleTheme(value);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    _buildSectionTitle("SESSION"),
                    SettingsGroup(
                      children: [
                        SettingsTile(
                          title: "Logout",
                          icon: Icons.logout,
                          contentColor: AppColors.errorRed,
                          onTap: () {
                            AppDialogs.showLogoutDialog(
                              context,
                              onConfirm: () => sl<AuthRepo>().logout(),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Column(
    children: [
      SizedBox(height: 32.h),
      Text(
        title,
        style: AppTextStyles.grey12w500TextStyle.copyWith(letterSpacing: 1.2),
      ),
      SizedBox(height: 16.h),
    ],
  );
}
