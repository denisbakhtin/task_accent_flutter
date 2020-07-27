import 'package:flutter/material.dart';

ThemeData taskAccentTheme(BuildContext context) {
  ThemeData parentTheme = Theme.of(context);
  return ThemeData(
    primaryColor: Color(0xFF00BD89),
    primaryColorDark: Color(0xFF232F34),
    primaryColorLight: Color(0xFFb2fab4),
    scaffoldBackgroundColor: Color(0xFFEFEFEF),
    accentColor: Color(0xFF8d6e63),
    canvasColor: Colors.white70, //I use it as ListTile background color
    fontFamily: 'WorkSans',
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        textTheme: TextTheme(
            headline6: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20))),
    //iconTheme: const IconThemeData(color: const Color(0xAAFFFFFF)),
    //iconTheme: const IconThemeData(color: ParticipantColors.iconColor),
    platform: parentTheme.platform,
    cursorColor: Color(0xFF4A6572),
    textSelectionColor: Color(0xFFF9AA33),
    textSelectionHandleColor: Color(0xFFF9AA33),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xFF00BD89),
      splashColor: Color(0xFF8d6e63),
      disabledColor: Color(0xFFb2fab4),
      shape: RoundedRectangleBorder(),
    ),
    textTheme: parentTheme.textTheme.copyWith(
      bodyText1: TextStyle(
        color: Color(0xFF7D7D7D),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
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
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      button: TextStyle(color: Color(0xFFFFFFFF)),
    ),
    //fontFamily: 'OpenSans',
  );
}
