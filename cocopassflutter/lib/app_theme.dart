import 'package:flutter/material.dart';

class AppTheme {
  static const Color primarySeedColor = const Color(0xFF6f00ff);
  static const Color secondarySeedColor = const Color(0xFF6750A4);
  static const Color tertiarySeedColor = const Color(0xFF2B2930);

  static ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: primarySeedColor, brightness: Brightness.dark));
  }
}