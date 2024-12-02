import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> lightModeColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.white,
    Colors.cyan,
    Colors.orange,
    Colors.grey,
    Colors.pink,
    Colors.amber,
    Colors.lime,
    Colors.purple
  ];

  static List<Color> darkModeColors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.black45,
    Colors.white30,
    Colors.cyanAccent,
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.pinkAccent,
    Colors.amberAccent,
    Colors.limeAccent,
    Colors.deepPurple
  ];

  static Color getColor(int index, bool isDarkMode) {
    return isDarkMode ? darkModeColors[index] : lightModeColors[index];
  }
}
