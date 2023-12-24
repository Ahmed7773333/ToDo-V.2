import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/app_theme.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/core/utils/app_styles.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/profile_row.dart';
import 'package:todo/features/Settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsPro = Provider.of<SettingsProvider>(context);
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 24.r),
        ),
        title: Text(strings.settings,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.settings,
                style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 16.w),
            profileRow(
                Image.asset(AppImages.brush,
                    color: Theme.of(context).cardColor),
                strings.changeappcolor, () async {
              ThemeData mode = await showChangeAppColor(context);
              if (settingsPro.mode != mode) {
                settingsPro.setTheme(mode);
              }
            }, context),
            SizedBox(height: 32.w),
            profileRow(
                Image.asset(AppImages.language,
                    color: Theme.of(context).cardColor),
                strings.changeapplanguage, () async {
              Locale mode = await showChangeAppLanguage(context);
              if (settingsPro.local != mode) {
                settingsPro.setLocale(mode);
              }
            }, context),
          ],
        ),
      ),
    );
  }

  Future<ThemeData> showChangeAppColor(context) async {
    Completer<ThemeData> completer = Completer<ThemeData>();
    final colorss = Theme.of(context).colorScheme;

    await showDialog(
      context: context,
      builder: (context) {
        final strings = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: colorss.onPrimary,
          surfaceTintColor: colorss.onPrimary,
          content: Row(
            children: [
              InkWell(
                onTap: () {
                  completer.complete(AppTheme.lightMode);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60.h,
                  width: 110.w,
                  color: AppColors.lightPrimary,
                  child: Center(
                    child: Text(
                      strings.light,
                      style: AppStyles.title.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  completer.complete(AppTheme.darkMode);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60.h,
                  width: 110.w,
                  color: AppColors.primary,
                  child: Center(
                    child: Text(
                      strings.dark,
                      style: AppStyles.title
                          .copyWith(color: AppColors.lightPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }

  Future<Locale> showChangeAppLanguage(context) async {
    Completer<Locale> completer = Completer<Locale>();
    final colorss = Theme.of(context).colorScheme;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colorss.onPrimary,
          surfaceTintColor: colorss.onPrimary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  completer.complete(const Locale('en'));
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                    child: Text(
                      'English',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  completer.complete(const Locale('ar'));

                  Navigator.pop(context);
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                    child: Text(
                      "عربي",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  completer.complete(const Locale('it'));

                  Navigator.pop(context);
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                    child: Text(
                      "Italiano",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  completer.complete(const Locale('fr'));

                  Navigator.pop(context);
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                    child: Text(
                      "Français",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  completer.complete(const Locale('de'));

                  Navigator.pop(context);
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                    child: Text(
                      "Deutsch",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }
}
