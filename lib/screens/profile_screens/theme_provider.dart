import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale? _locale;

  bool get isDarkMode => _isDarkMode;
  Locale? get locale => _locale;

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    saveTheme(isOn);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;

    String? langCode = prefs.getString('selectedLanguage');
    if (langCode != null) {
      _locale = Locale(langCode);
    }

    notifyListeners();
  }

  void saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  void setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', locale.languageCode);
    notifyListeners();
  }


  void clearLocale() async {
    _locale = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedLanguage');
    notifyListeners();
  }
}
