import "package:flutter/material.dart";

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.grey,
      surface: Colors.grey[700],
      secondary: Colors.grey[600],
      primary: Colors.grey[850],
      onPrimary: Colors.white),
  scaffoldBackgroundColor: Colors.grey[700],
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontSize: 30),
      bodySmall: TextStyle(fontSize: 18)),
);
