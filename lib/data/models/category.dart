import 'package:flutter/material.dart'; // for the icon class

class Category {
  String _name;
  String _color; // (Hex code?)
  Icon _icon;
  // Optional, a description (?)
  // icon (icons.)

  Category({required String name, required String color, required Icon icon})
      : _color = color,
        _name = name,
        _icon = icon;
}
