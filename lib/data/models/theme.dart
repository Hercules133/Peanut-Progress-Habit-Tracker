import 'package:flutter/material.dart';
import 'package:streaks/data/models/own_colors.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Colors.brown.shade100, // Background
    primary: Colors.brown.shade300, // Highlight
    onSurface: const Color(0xFF3A3A3A), // Text
  ),
  extensions: const <ThemeExtension<OwnColors>>[
    OwnColors(
      contribution0: Color(0xFFF5F5F5), // Very light gray
      contribution1: Color(0xFFF0E0D6), // Pale beige
      contribution2: Color(0xFFEAC8B3), // Light peach
      contribution3: Color(0xFFFFB085), // Soft orange
      contribution4: Color(0xFFFF9E6A), // Warm coral
      contribution5: Color(0xFFFF8A4D), // Vibrant orange
      contributionDefault: Color(0xFFC4A98C), // Light tawny
      category1: Color(0xFFF0E0D6), // Pale beige
      category2: Color(0xFFE9D4C3), // Blush beige
      category3: Color(0xFFE6C4A6), // Sandstone
      category4: Color(0xFFFFB085), // Soft orange
      category5: Color(0xFFFF9E6A), // Warm coral
      category6: Color(0xFFFF8A4D), // Vibrant orange
      category7: Color(0xFFE3B999), // Light copper
      category8: Color(0xFFD9B8A2), // Desert tan
      category9: Color(0xFFC9A48B), // Light rust
      category10: Color(0xFFB29277), // Soft mahogany
    ),
  ],
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Colors.brown.shade900, //Background
    primary: Colors.brown.shade700, //Highlight
    onSurface: const Color(0xffc5cacd), //text
  ),
  extensions: const <ThemeExtension<OwnColors>>[
    OwnColors(
      contribution0: Color(0xFFDBDBDB),
      contribution1: Color(0xFFD3B09C),
      contribution2: Color(0xFFD6916B),
      contribution3: Color(0xFFFB7F3C),
      contribution4: Color(0xFFFD6D24),
      contribution5: Color(0xFFFF5A00),
      contributionDefault: Color(0xFF9B815D),
      category1: Color(0xFFD3B09C), // Beige
      category2: Color(0xFFD6A579), // Sand
      category3: Color(0xFFE09165), // Terracotta
      category4: Color(0xFFFB7A45), // Orange
      category5: Color(0xFFFF6B3C), // Coral
      category6: Color(0xFFFF5E1A), // Vermilion
      category7: Color(0xFFD97A4C), // Copper
      category8: Color(0xFFC58F70), // Tawny
      category9: Color(0xFFB97E66), // Rust
      category10: Color(0xFFA56E5A), // Mahogany
    ),
  ],
);
