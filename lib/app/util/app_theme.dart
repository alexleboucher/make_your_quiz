import 'package:flutter/material.dart';

ColorScheme _getColorScheme(ThemeMode mode, Color mainColor) {
  return ColorScheme.fromSeed(
    seedColor: mainColor,
    primary: mainColor,
    shadow: Colors.black.withOpacity(0.7),
    brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
  );
}

class AppTheme {
  static ThemeData getTheme({
    required ThemeMode themeMode,
    required Color mainColor,
  }) {
    final colorScheme = _getColorScheme(themeMode, mainColor);
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.only(bottom: 5),
      ),
    );
  }
}
