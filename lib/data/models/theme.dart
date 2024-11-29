import 'package:flutter/material.dart';
import 'package:streaks/data/models/ownColors.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Colors.brown.shade100,
    primary: Colors.brown.shade700, //Highlight
    onSurface: const Color(0xff1e1c1c), //text
  ),
  extensions: const <ThemeExtension<OwnColors>>[
    OwnColors(
      contribution0: Color(0xFFDBDBDB),
      contribution1: Color(0xFFD3B09C),
      contribution2: Color(0xFFD6916B),
      contribution3: Color(0xFFFB7F3C),
      contribution4: Color(0xFFFD6D24),
      contribution5: Color(0xFFFF5A00),
      category1: Color(0xFFD3B09C),
      category2: Color(0xFFD3B09C),
      category3: Color(0xFFD3B09C),
      category4: Color(0xFFD3B09C),
      category5: Color(0xFFD3B09C),
      category6: Color(0xFFD3B09C),
      category7: Color(0xFFD3B09C),
      category8: Color(0xFFD3B09C),
      category9: Color(0xFFD3B09C),
      category10: Color(0xFFD3B09C),
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
      category1: Color(0xFFD3B09C),
      category2: Color(0xFFD3B09C),
      category3: Color(0xFFD3B09C),
      category4: Color(0xFFD3B09C),
      category5: Color(0xFFD3B09C),
      category6: Color(0xFFD3B09C),
      category7: Color(0xFFD3B09C),
      category8: Color(0xFFD3B09C),
      category9: Color(0xFFD3B09C),
      category10: Color(0xFFD3B09C),
    ),
  ],
);
