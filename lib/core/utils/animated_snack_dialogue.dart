import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

showAnimatedSnakDialogue(
  BuildContext context, {
  String? message,
  AnimatedSnackBarType? type,
}) {
  return AnimatedSnackBar.material(
    message ?? "",
    type: type ?? AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition
        .bottom, // Position of snackbar on mobile devices// Position of snackbar on desktop devices
  ).show(context);
}
