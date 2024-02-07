import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color(0x00282828),
    primary: const Color(0x00ba9ffb),
    secondary: Colors.deepPurple.shade100,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFFBB86FC),
    secondary: const Color(0xFF03DAC6),
    background: const Color(0xFF121212),
    surface: const Color(0xFF121212),
    error: const Color(0xFFCF6679),
    onPrimary: const Color(0xFF000000),
    onSecondary: const Color(0xFF000000),
    onBackground: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFFFFFFFF).withOpacity(0.67),
    onError: const Color(0xFF000000),
    surfaceVariant: const Color(0xFF1A1A1A),
    secondaryContainer: const Color(0xFF202020),
  ),
  canvasColor: const Color(0xFFFFFFFF).withOpacity(0.67),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
  ),
);
