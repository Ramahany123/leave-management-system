import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/models/user_model.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/core/widgets/logout_dialog.dart';
import 'package:leave_management_system/features/profile/ui/widgets/language_bottom_sheet.dart';
import 'package:leave_management_system/features/profile/ui/widgets/personal_info_bottom_sheet.dart';
import 'package:leave_management_system/features/profile/ui/widgets/upload_signature_bottom_sheet.dart';

import '../../features/profile/logic/cubit/upload_signature_cubit.dart';

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

  static void showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  static void showUploadSignatureSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (context) => sl<UploadSignatureCubit>(),
        child: UploadSignatureBottomSheet(),
      ),
    );
  }
}
