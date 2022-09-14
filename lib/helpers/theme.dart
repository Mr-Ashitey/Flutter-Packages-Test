import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  // Elevated Button Theme Data
  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return green, otherwise blue
        if (states.contains(MaterialState.pressed)) {
          return Colors.green;
        }
        return Colors.black;
      }),
    ),
  );

  // Floating Action Button Theme Data
  static const FloatingActionButtonThemeData _floatingActionButtonThemeData =
      FloatingActionButtonThemeData(backgroundColor: Colors.black);

  // Main theme to be used in main
  static ThemeData get mainTheme => ThemeData(
        textTheme: GoogleFonts.senTextTheme(),
        appBarTheme: const AppBarTheme(color: Colors.black),
        elevatedButtonTheme: _elevatedButtonThemeData,
        floatingActionButtonTheme: _floatingActionButtonThemeData,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
