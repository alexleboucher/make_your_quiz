import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 228, 0, 0),
  primary: const Color.fromARGB(255, 222, 28, 28),
  shadow: Colors.grey.withOpacity(0.8),
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 228, 0, 0),
  primary: const Color.fromARGB(255, 227, 47, 47),
  shadow: Colors.black.withOpacity(0.7),
  brightness: Brightness.dark,
);

class AppTheme {
  static ThemeData getTheme({required ThemeMode themeMode}) {
    final colorScheme =
        themeMode == ThemeMode.light ? lightColorScheme : darkColorScheme;
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }
}
