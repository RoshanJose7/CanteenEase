import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var LightTheme = ThemeData.light().copyWith(
  cardTheme: const CardTheme(
    clipBehavior: Clip.antiAlias,
    elevation: 1,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFF9F0D),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  ),
  primaryColor: const Color(0xFFFF9F0D),
  // primaryColorLight: const Color(0xFFffd44f),
  // primaryColorDark: const Color(0xFFc37400),
  scaffoldBackgroundColor: const Color(0xFFDFE0DF),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        onSurface: Colors.white,
        side: const BorderSide(
          width: 1,
          color: Color(0xFFFCA311),
        )),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 96,
      color: Colors.black,
    )),
    headline2: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 60,
      color: Colors.black,
    )),
    headline3: GoogleFonts.montserrat(
        textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 48)),
    headline4: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 34,
      color: Colors.black,
    )),
    headline5: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Colors.black,
    )),
    headline6: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black,
    )),
    bodyText1: GoogleFonts.poppins(
        textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    )),
    bodyText2: GoogleFonts.poppins(
        textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    )),
    button: GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    )),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFFFF9F0D),
    primaryVariant: Color(0xFFFCA311),
    secondary: Color(0xFFFF9F0D),
    secondaryVariant: Color(0xFFFF9F0D),
    background: Colors.white,
    surface: Color(0xFFc7ddff),
    onSurface: Color(0xFFf0f0f0),
    onPrimary: Color(0xFF010101),
    onError: Colors.red,
    onSecondary: Colors.white,
    onBackground: Color(0xFF010101),
    error: Colors.redAccent,
    brightness: Brightness.light,
  ),
);
