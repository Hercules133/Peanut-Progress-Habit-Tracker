import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/color_ex.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;
  final bool isDefault;

  Category({
    required this.name,
    required this.color,
    required this.icon,
    this.isDefault = false,
  });

  static List<Category> defaultCategories() {
    return [
      Category(
        name: 'All',
        color: const Color(0xFFC58F70),
        icon: Icons.list_alt,
        isDefault: true,
      ),
    ];
  }

  factory Category.defaultCategory() {
    return defaultCategories().first;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.toARGB32,
      'icon': icon.codePoint,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      color: Color(map['color']),
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Category) return false;

    bool name = this.name == other.name;
    bool color = this.color.toARGB32 == other.color.toARGB32;
    bool icon = this.icon == other.icon;

    return name && color && icon;
  }

  @override
  int get hashCode => Object.hash(name, color, icon);
}
