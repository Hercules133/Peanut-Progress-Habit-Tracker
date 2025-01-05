import 'package:flutter/material.dart';
import '/data/models/own_colors.dart';

ThemeData lightMode = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 1),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintStyle: TextStyle(color: Colors.brown.shade200),
    filled: true,
    fillColor: Colors.brown.shade300,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.brown.shade200,
  ),
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Colors.brown.shade200, // Background
    primary: Colors.brown.shade300, // Highlight
    onSurface: const Color(0xFF3A3A3A), // Text
    onPrimary: const Color(0xFF5E4C46),
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
      category1: Color(0xFFDCC9BF), // Darker Pale beige
      category2: Color(0xFFD1B9AD), // Darker Blush beige
      category3: Color(0xFFC5A687), // Darker Sandstone
      category4: Color(0xFFE09B73), // Darker Soft orange
      category5: Color(0xFFD88458), // Darker Warm coral
      category6: Color(0xFFD67141), // Darker Vibrant orange
      category7: Color(0xFFC2A080), // Darker Light copper
      category8: Color(0xFFBFA28B), // Darker Desert tan
      category9: Color(0xFFAD8F78), // Darker Light rust
      category10: Color(0xFF9C7E68), // Darker Soft mahogany
      habitText: Color(0xFF5D4037),
    ),
  ],
);

ThemeData darkMode = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xffc5cacd), width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 1),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintStyle: TextStyle(color: Colors.brown.shade900),
    filled: true,
    fillColor: Colors.brown.shade700,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.brown.shade900,
  ),
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Colors.brown.shade900, //Background
    primary: Colors.brown.shade700, //Highlight
    onSurface: const Color(0xffc5cacd), //text
    onPrimary: const Color(0xFF5E4C46),
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
      habitText: Color(0xFF3E2723),
    ),
  ],
);
