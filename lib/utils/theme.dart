import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textTheme: GoogleFonts.latoTextTheme(),
      primaryColor: Colors.purple,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      textTheme: GoogleFonts.latoTextTheme(),
      primaryColor: Colors.purple,
      brightness: Brightness.dark,
    );
  }
}
