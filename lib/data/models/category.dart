import 'package:flutter/material.dart'; // for the icon class

class Habitcategory {
  String _name;
  String _color; // (Hex code?)
  Icon _icon;

  Habitcategory({
    required String name,
    required String color,
    required Icon icon,
  })  : _name = name,
        _color = color,
        _icon = icon;

  // Getter and Setter for _name
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  // Getter and Setter for _color
  String get color => _color;
  set color(String value) {
    _color = value;
  }

  // Getter and Setter for _icon
  Icon get icon => _icon;
  set icon(Icon value) {
    _icon = value;
  }
}
