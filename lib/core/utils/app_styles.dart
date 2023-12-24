import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle title = const TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleOfItems = TextStyle(
    color: Colors.white.withOpacity(0.8700000047683716),
    fontSize: 20,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700,
  );
  static TextStyle searchStyle = const TextStyle(
    color: Color(0xFFAFAFAF),
    fontSize: 18,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
  );
  static TextStyle taskTitleStyle = TextStyle(
    color: Colors.white.withOpacity(0.8700000047683716),
    fontSize: 16,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    letterSpacing: -0.32,
  );
  static TextStyle smallStyle = const TextStyle(
    color: Color(0xFFAFAFAF),
    fontSize: 14,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    letterSpacing: -0.32,
  );
}
