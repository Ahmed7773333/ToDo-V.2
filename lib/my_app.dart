// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/features/Settings/settings_provider.dart';
import 'config/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  static final MyApp _instance = MyApp._internal();

  factory MyApp() {
    return _instance;
  }

  MyApp._internal();

  @override
  Widget build(BuildContext context) {
    checkEveryDay();
    final settingsPro = Provider.of<SettingsProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: settingsPro.mode,
        locale: settingsPro.local,
        onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
      ),
    );
  }
}
