import 'package:flutter/material.dart';

class SwitchState with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners();
  }
}
