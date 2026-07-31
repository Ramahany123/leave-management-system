import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/url_launcher_utils.dart';

import '../networking/errors/exceptions.dart';

//TODO: localize text
extension ContextUrlExtension on BuildContext {
  Future<void> openAttachemnt(String url) async {
    try {
      await UrlLauncherUtils.openExternalUrl(url);
    } on UrlLaunchException catch (_) {
      if (mounted) {
        showAnimatedSnakDialogue(
          this,
          message: 'Could not open document. Please try again.',
          type: AnimatedSnackBarType.error,
        );
      }
    } on FormatException catch (_) {
      if (mounted) {
        showAnimatedSnakDialogue(
          this,
          message: 'The attachment link is invalid.',
          type: AnimatedSnackBarType.error,
        );
      }
    }
  }
}
