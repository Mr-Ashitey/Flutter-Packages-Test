import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get mainTheme => ThemeData(
        textTheme: GoogleFonts.senTextTheme(),
        appBarTheme: const AppBarTheme(color: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return Colors.green;
              }
              return Colors.black;
            }),
          ),
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
