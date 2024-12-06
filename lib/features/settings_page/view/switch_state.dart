import 'package:flutter/material.dart';

class SwitchState with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleSwitch(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
