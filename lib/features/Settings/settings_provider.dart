import 'package:flutter/material.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';

import '../../config/app_theme.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData _mode = userDbHelper.getAll().isEmpty
      ? AppTheme.darkMode
      : (userDbHelper.getAll().first.isDark ?? true)
          ? AppTheme.darkMode
          : AppTheme.lightMode;
  Locale _local = userDbHelper.getAll().isEmpty
      ? const Locale('en')
      : Locale(userDbHelper.getAll().first.isEnglish ?? 'en');
  Locale get local => _local;
  ThemeData get mode => _mode;
  void setTheme(ThemeData mod) {
    userDbHelper.getAll().first.isDark =
        !(userDbHelper.getAll().first.isDark ?? false);
    userDbHelper.update(
        userDbHelper.getAll().first.key, userDbHelper.getAll().first);
    _mode = mod;
    notifyListeners();
  }

  void setLocale(Locale loc) {
    userDbHelper.getAll().first.isEnglish = loc.languageCode;
    userDbHelper.update(
        userDbHelper.getAll().first.key, userDbHelper.getAll().first);
    _local = loc;
    notifyListeners();
  }
}
