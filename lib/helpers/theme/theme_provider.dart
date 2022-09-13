import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDark = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _isDark;

  void toggleTheme() {
    _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark;
    _isDark = !_isDark;
    notifyListeners();
  }
}
