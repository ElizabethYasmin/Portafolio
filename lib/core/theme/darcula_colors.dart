import 'package:flutter/material.dart';

/// Paleta de colores Android Studio / Android Oficial
class DarculaColors {
  DarculaColors._();

  // Fondos
  static const Color background = Color(0xFF2B2B2B);
  static const Color backgroundLight = Color(0xFF313335);
  static const Color panel = Color(0xFF3C3F41);
  static const Color panelHover = Color(0xFF4E5254);
  static const Color toolbar = Color(0xFF3C3F41);

  // Bordes
  static const Color border = Color(0xFF555555);
  static const Color borderLight = Color(0xFF646464);

  // Texto - Paleta Android Studio
  static const Color text = Color(0xFFCCCCCC);         // Gris Suave
  static const Color textBright = Color(0xFFFFFFFF);    // Blanco
  static const Color textDim = Color(0xFF666666);       // Gris Intenso
  static const Color textMuted = Color(0xFF606366);

  // Colores Android Oficiales
  static const Color androidGreen = Color(0xFFA4C639);     // Verde Android Oficial
  static const Color androidGreenMate = Color(0xFF669933); // Verde Mate (Iconos AS)
  static const Color grayIntense = Color(0xFF666666);      // Gris Intenso (Iconos AS)
  static const Color graySoft = Color(0xFFCCCCCC);         // Gris Suave (Iconos AS)

  // Syntax highlighting con colores Android
  static const Color keyword = Color(0xFFA4C639);       // Verde Android - keywords
  static const Color string = Color(0xFF669933);         // Verde Mate - strings
  static const Color number = Color(0xFF6897BB);         // azul - numbers
  static const Color comment = Color(0xFF666666);        // Gris Intenso - comments
  static const Color annotation = Color(0xFFA4C639);     // Verde Android - annotations
  static const Color classRef = Color(0xFFFFC66D);       // dorado - class names
  static const Color method = Color(0xFFFFC66D);         // dorado - methods
  static const Color field = Color(0xFFCCCCCC);          // Gris Suave - fields

  // Colores de acción
  static const Color selection = Color(0xFF214283);
  static const Color activeTab = Color(0xFF4E5254);
  static const Color tabIndicator = Color(0xFFA4C639);   // Verde Android
  static const Color link = Color(0xFFA4C639);            // Verde Android
  static const Color success = Color(0xFFA4C639);         // Verde Android
  static const Color error = Color(0xFFBC3F3C);
  static const Color warning = Color(0xFFFFC66D);

  // Gutter / línea de números
  static const Color gutter = Color(0xFF313335);
  static const Color lineNumber = Color(0xFF606366);
}
