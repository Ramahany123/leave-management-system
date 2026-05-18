import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../styles/app_colors.dart';

extension RequestStatusExtension on String {
  Color get getStatusColor {
    switch (this) {
      case RequestStatues.approved:
        return AppColors.successGreen;
      case RequestStatues.rejected:
        return AppColors.errorRed;
      case RequestStatues.pending:
        return AppColors.pendingYellow;
      case RequestStatues.cancelled:
        return AppColors.greyColor;
      default:
        return AppColors.greyColor;
    }
  }

  IconData get getStatusIcon {
    switch (this) {
      case RequestStatues.approved:
        return Icons.check_circle_outline;
      case RequestStatues.rejected:
      case RequestStatues.cancelled:
        return Icons.cancel_outlined;
      case RequestStatues.pending:
        return Icons.access_time;
      default:
        return Icons.help_outline;
    }
  }
}
