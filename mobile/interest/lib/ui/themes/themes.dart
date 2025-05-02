import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color _primaryColor = Colors.blue;

ThemeData get lightTheme => ThemeData(
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    onSecondary: Colors.white,
    surface: Colors.lightBlue.shade200,
    onSurface: Colors.black, 
    brightness: Brightness.light, 
  )
);

ThemeData get darkTheme => ThemeData(
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: Color(0xFF353535), 
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    onSecondary: Colors.black,
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
);

extension ThemePlatformExtension on ThemeData{
  bool get isMaterial => defaultTargetPlatform == TargetPlatform.android;
  bool get isCupertino => defaultTargetPlatform == TargetPlatform.iOS;

  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
