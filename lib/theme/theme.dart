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
  colorScheme: const ColorScheme.dark(
      background: Color(0xFF121212),
      onBackground: Color(0xFF8b8b8b),
      primary: Color(0xFF282828),
      secondary: Color(0xFF575757),
      tertiary: Color(0xFF)),
);
