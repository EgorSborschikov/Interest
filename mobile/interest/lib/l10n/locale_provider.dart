import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); 

  Locale get locale => _locale;

  void switchToEnglish() {
    _locale = const Locale('en');
    notifyListeners(); 
  }

  void switchToRussian() {
    _locale = const Locale('ru');
    notifyListeners(); 
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners(); 
  }

  Future<void> saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }


  Future<void> loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}