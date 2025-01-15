import 'package:flutter/material.dart';

/// A class that manages the theme mode state utilizing the [ChangeNotifier] mixin to allow listeners to react to changes in the theme mode.
class SwitchState with ChangeNotifier {
  /// Private variable to store the current theme mode. Defaults to [ThemeMode.system].
  ThemeMode _themeMode = ThemeMode.system;

  /// Getter for the current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Method to update the theme mode and notify listeners about the change.
  ///
  /// [newThemeMode] The new theme mode to be set.
  void toggleThemeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners();
  }
}
