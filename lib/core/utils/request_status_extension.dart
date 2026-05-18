import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../styles/app_colors.dart';

extension RequestStatusExtension on String {
  Color get getStatusColor {
    switch (this) {
      case RequestStatus.approved:
        return AppColors.successGreen;
      case RequestStatus.rejected:
        return AppColors.errorRed;
      case RequestStatus.pending:
        return AppColors.pendingYellow;
      case RequestStatus.cancelled:
        return AppColors.greyColor;
      default:
        return AppColors.greyColor;
    }
  }

  IconData get getStatusIcon {
    switch (this) {
      case RequestStatus.approved:
        return Icons.check_circle_outline;
      case RequestStatus.rejected:
      case RequestStatus.cancelled:
        return Icons.cancel_outlined;
      case RequestStatus.pending:
        return Icons.access_time;
      default:
        return Icons.help_outline;
    }
  }
}
