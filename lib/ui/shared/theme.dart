import 'package:flutter/material.dart';

ThemeData taskAccentTheme(BuildContext context) {
  ThemeData parentTheme = Theme.of(context);
  return ThemeData(
    primaryColor: Color(0xFF344955),
    primaryColorDark: Color(0xFF232F34),
    primaryColorLight: Color(0xFF4A6572),
    scaffoldBackgroundColor: Color(0xFFEFEFEF),
    accentColor: Color(0xFFF9AA33),
    fontFamily: 'WorkSans',
    //iconTheme: const IconThemeData(color: const Color(0xAAFFFFFF)),
    //iconTheme: const IconThemeData(color: ParticipantColors.iconColor),
    platform: parentTheme.platform,
    cursorColor: Color(0xFF4A6572),
    textSelectionColor: Color(0xFFF9AA33),
    textSelectionHandleColor: Color(0xFFF9AA33),
    buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: Color(0xFF344955),
        splashColor: Color(0xFFF9AA33),
        disabledColor: Color(0xFF4A6572),
        shape: RoundedRectangleBorder()),
    textTheme: parentTheme.textTheme.copyWith(
      body1: TextStyle(
        color: Color(0xFF7D7D7D),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      body2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      title: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      subhead: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    //fontFamily: 'OpenSans',
  );
}
