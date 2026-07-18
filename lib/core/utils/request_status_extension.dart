import 'package:flutter/material.dart';
import 'package:leave_management_system/core/theme/app_colors.dart';

import '../constants/app_constants.dart';

extension RequestStatusExtension on String {
  Color get getStatusColor {
    switch (this) {
      case RequestStatues.approved:
        return AppColors.successGreen;
      case RequestStatues.rejected:
        return AppColors.errorRed;
      case RequestStatues.pending:
        return AppColors.pendingAmber;
      case RequestStatues.cancelled:
        return AppColors.slate500;
      default:
        return AppColors.slate500;
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
