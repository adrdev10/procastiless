import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MainThemeInterface {
  final gradiant = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xff7E33B8), Color(0xffEE5A3A)])
      .createShader(Rect.fromLTWH(0, 0, 0.0, 150.0));
  ThemeData getTheme();
}

class MainTheme extends MainThemeInterface {
  @override
  ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Poppings',
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            color: Color(0xff2d4a63), fontWeight: FontWeight.bold),
        displayLarge: GoogleFonts.poppins(color: Color(0xff525252)),
        displayMedium: GoogleFonts.poppins(color: Color(0xff2d4a63)),
        displaySmall: GoogleFonts.poppins(
            color: Color(0xff525252),
            fontWeight: FontWeight.bold,
            fontSize: 30),
        headlineMedium:
            GoogleFonts.poppins(foreground: Paint()..shader = gradiant),
        headlineSmall: TextStyle(
            color: Color(0xff3378B8),
            fontWeight: FontWeight.bold,
            letterSpacing: .02),
        titleLarge: TextStyle(foreground: Paint()..shader = gradiant),
        titleMedium: GoogleFonts.poppins(
            color: Color(0xff3378B8), fontWeight: FontWeight.bold),
        bodyMedium: GoogleFonts.poppins(
            color: Color(0xff2d4a63), fontWeight: FontWeight.bold),
      ),
    );
  }
}
