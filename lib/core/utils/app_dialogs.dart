import 'package:flutter/material.dart';
import 'package:leave_management_system/core/models/user_model.dart';
import 'package:leave_management_system/core/widgets/logout_dialog.dart';
import 'package:leave_management_system/features/profile/ui/widgets/personal_info_bottom_sheet.dart';

class AppDialogs {
  static void showLogoutDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(onConfirm: onConfirm),
    );
  }

  static void showPersonalInfoSheet(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PersonalInfoBottomSheet(user: user),
    );
  }
}
