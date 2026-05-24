import 'package:easy_localization/easy_localization.dart';

extension DateFormatter on DateTime {
  String get toReadableDate {
    return DateFormat("MMM dd, yyyy").format(this);
  }

  String get toShortDate {
    return DateFormat("dd/MM/yyyy").format(this);
  }
}
