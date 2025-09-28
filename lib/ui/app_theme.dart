import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarySwatch = Colors.indigo;

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch).copyWith(secondary: Colors.indigoAccent),
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: primarySwatch,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primarySwatch),
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
