import 'package:flutter/material.dart';

class AppTheme {
  static Color primarySeedColor = const Color(0xFF6f00ff);
  static Color secondarySeedColor = const Color(0xFF6750A4);
  static Color tertiarySeedColor = const Color(0xFF2B2930);

  static ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: primarySeedColor, brightness: Brightness.dark));
  }
}
