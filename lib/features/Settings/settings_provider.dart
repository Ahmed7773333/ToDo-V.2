import 'package:flutter/material.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';

import '../../config/app_theme.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData _mode = UserDbHelper.getAll().isEmpty
      ? AppTheme.darkMode
      : (UserDbHelper.getAll().first.isDark ?? true)
          ? AppTheme.darkMode
          : AppTheme.lightMode;
  Locale _local = UserDbHelper.getAll().isEmpty
      ? const Locale('en')
      : Locale(UserDbHelper.getAll().first.isEnglish ?? 'en');
  Locale get local => _local;
  ThemeData get mode => _mode;
  void setTheme(ThemeData mod) {
    UserDbHelper.getAll().first.isDark =
        !(UserDbHelper.getAll().first.isDark ?? false);
    UserDbHelper.update(
        UserDbHelper.getAll().first.key, UserDbHelper.getAll().first);
    _mode = mod;
    notifyListeners();
  }

  void setLocale(Locale loc) {
    UserDbHelper.getAll().first.isEnglish = loc.languageCode;
    UserDbHelper.update(
        UserDbHelper.getAll().first.key, UserDbHelper.getAll().first);
    _local = loc;
    notifyListeners();
  }
}
