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

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'color': _color,
      'icon': {
        'codePoint': _icon.icon?.codePoint,
        'fontFamily': _icon.icon?.fontFamily,
        'fontPackage': _icon.icon?.fontPackage,
      },
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      color: map['color'],
      icon: Icon(
        IconData(
          map['icon']['codePoint'],
          fontFamily: map['icon']['fontFamily'],
          fontPackage: map['icon']['fontPackage'],
        ),
      ),
    );
  }
}
