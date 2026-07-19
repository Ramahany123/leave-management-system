import 'package:easy_localization/easy_localization.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';

class AppValidators {
  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validators_field_required.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validators_email_required.tr();
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return LocaleKeys.validators_invalid_email.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validators_password_required.tr();
    }
    if (value.length < 8) {
      return LocaleKeys.validators_password_min_length.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validators_confirm_password_required.tr();
    }
    if (value != password) {
      return LocaleKeys.validators_passwords_do_not_match.tr();
    }
    return null;
  }
}
