import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';

class AppTheme {
  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onPrimary,
      error: AppColors.secondary,
      onError: AppColors.secondary,
      background: AppColors.onPrimary,
      onBackground: AppColors.secondary,
      surface: AppColors.onPrimary,
      onSurface: AppColors.secondary,
    ),
    canvasColor: Colors.black,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFB4B4B4)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 18,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
      bodySmall: TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 14,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.onPrimary,
        filled: true,
        enabledBorder: InputBorder.none,
        focusColor: AppColors.onPrimary,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        hintStyle: AppStyles.searchStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(327, 48),
        backgroundColor: AppColors.secondary,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(color: AppColors.secondary),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.onPrimary,
      dividerColor: Colors.white,
    ),
    timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColors.onPrimary,
        dayPeriodTextStyle: TextStyle(
          color: AppColors.lightPrimary,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        hourMinuteTextStyle: TextStyle(
          color: AppColors.lightPrimary,
          fontSize: 30,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.onPrimary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: Colors.white.withOpacity(0.8700000047683716),
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppColors.lightonPrimary,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
      selectedItemColor: Colors.white,
      unselectedItemColor: AppColors.lightonPrimary,
    ),
    cardColor: Colors.white,
  );
  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: AppColors.lightPrimary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightonPrimary,
      secondary: AppColors.lightsecondry,
      onSecondary: AppColors.lightonPrimary,
      error: AppColors.lightsecondry,
      onError: AppColors.lightsecondry,
      background: AppColors.lightonPrimary,
      onBackground: AppColors.lightsecondry,
      surface: AppColors.lightonPrimary,
      onSurface: AppColors.lightsecondry,
    ),
    canvasColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 23,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFB4B4B4)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 23,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 53, 52, 52),
        fontSize: 18,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
      bodySmall: TextStyle(
        color: Color.fromARGB(255, 53, 52, 52),
        fontSize: 14,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
    ),
    cardColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.lightonPrimary,
        filled: true,
        enabledBorder: InputBorder.none,
        focusColor: AppColors.lightonPrimary,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        hintStyle: AppStyles.searchStyle.copyWith(color: Colors.black)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(327, 48),
        backgroundColor: AppColors.lightsecondry,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(color: AppColors.lightsecondry),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.lightonPrimary,
      dividerColor: AppColors.lightsecondry,
    ),
    timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColors.lightonPrimary,
        dayPeriodTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        hourMinuteTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 30,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.lightonPrimary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: AppColors.onPrimary,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppColors.onPrimary,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ).copyWith(color: AppColors.onPrimary),
      selectedItemColor: Colors.black,
      unselectedItemColor: AppColors.onPrimary,
    ),
  );
}
