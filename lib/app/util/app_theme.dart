import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 21, 120, 234),
  primary: const Color.fromARGB(255, 48, 129, 222),
  shadow: Colors.grey.withOpacity(0.8),
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 21, 120, 234),
  primary: const Color.fromARGB(255, 48, 129, 222),
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
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.only(bottom: 5),
      ),
    );
  }
}
