import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/cache/cache_helper.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    _loadTheme();
  }

  void _loadTheme() {
    final bool? isDark = CacheHelper.getData(key: CacheKeys.isDarkMode);
    emit(isDark ?? false);
  }

  void toggleTheme(bool isDark) {
    CacheHelper.saveData(key: CacheKeys.isDarkMode, value: isDark);
    emit(isDark);
  }
}
