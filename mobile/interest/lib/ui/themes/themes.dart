import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color _primaryColor = Colors.blue;

ThemeData get lightTheme => ThemeData(
  primaryColor: _primaryColor,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  colorScheme: ColorScheme.light(
    primary: _primaryColor,
    secondary: Colors.blueAccent,
    surface: const Color(0xFFEFF1F3), // Фон компонентов
    onSurface: Colors.black, // Цвет текста/иконок на surface
    tertiary: Colors.grey.shade200
  ),
);

ThemeData get darkTheme => ThemeData(
  primaryColor: _primaryColor,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: _primaryColor,
    secondary: Colors.blueAccent,
    surface: Colors.black,
    onSurface: Colors.white,
    tertiary: Color.fromARGB(110, 51, 51, 51),
  ),
);

extension ThemePlatformExtension on ThemeData{
  bool get isMaterial => defaultTargetPlatform == TargetPlatform.android;
  bool get isCupertino => defaultTargetPlatform == TargetPlatform.iOS;

  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
