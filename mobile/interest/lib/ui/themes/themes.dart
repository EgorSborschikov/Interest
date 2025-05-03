import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color _primaryColor = Colors.blue;

ThemeData get lightTheme => ThemeData(
  primaryColor: _primaryColor,
  //scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: _primaryColor,
    secondary: Colors.blueAccent,
    surface: Colors.white, // Фон компонентов
    onSurface: Colors.black, // Цвет текста/иконок на surface
    background: Colors.white, // Фон Scaffold
  ),
);

ThemeData get darkTheme => ThemeData(
  primaryColor: _primaryColor,
  //scaffoldBackgroundColor: Color(0xFF353535), 
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: _primaryColor,
    secondary: Colors.blueAccent,
    surface: const Color.fromARGB(255, 29, 29, 29),
    onSurface: Colors.white,
    background: const Color.fromARGB(255, 29, 29, 29),
  ),
);

extension ThemePlatformExtension on ThemeData{
  bool get isMaterial => defaultTargetPlatform == TargetPlatform.android;
  bool get isCupertino => defaultTargetPlatform == TargetPlatform.iOS;

  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
