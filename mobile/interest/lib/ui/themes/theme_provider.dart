import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  bool _isDarkTheme = false;

  ThemeProvider(){
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool, value) async {
    _isDarkTheme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  }
}
