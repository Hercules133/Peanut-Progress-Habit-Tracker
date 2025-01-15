import 'package:flutter/material.dart';

/// A custom ThemeExtension to define the colors used in the application.
class OwnColors extends ThemeExtension<OwnColors> {
  /// Creates an instance of [OwnColors].
  const OwnColors({
    required this.contribution0,
    required this.contribution1,
    required this.contribution2,
    required this.contribution3,
    required this.contribution4,
    required this.contribution5,
    required this.contributionDefault,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.category8,
    required this.category9,
    required this.category10,
    required this.habitText,
  });

  /// Color for contribution level 0.
  final Color contribution0;

  /// Color for contribution level 1.
  final Color contribution1;

  /// Color for contribution level 2.
  final Color contribution2;

  /// Color for contribution level 3.
  final Color contribution3;

  /// Color for contribution level 4.
  final Color contribution4;

  /// Color for contribution level 5.
  final Color contribution5;

  /// Default color for contributions.
  final Color contributionDefault;

  /// Color for category 1.
  final Color category1;

  /// Color for category 2.
  final Color category2;

  /// Color for category 3.
  final Color category3;

  /// Color for category 4.
  final Color category4;

  /// Color for category 5.
  final Color category5;

  /// Color for category 6.
  final Color category6;

  /// Color for category 7.
  final Color category7;

  /// Color for category 8.
  final Color category8;

  /// Color for category 9.
  final Color category9;

  /// Color for category 10.
  final Color category10;

  /// Color for habit text.
  final Color habitText;

  /// Creates a copy of this [OwnColors] but with the given fields replaced with the new values.
  @override
  OwnColors copyWith({
    Color? contribution0,
    Color? contribution1,
    Color? contribution2,
    Color? contribution3,
    Color? contribution4,
    Color? contribution5,
    Color? contributionDefault,
    Color? category1,
    Color? category2,
    Color? category3,
    Color? category4,
    Color? category5,
    Color? category6,
    Color? category7,
    Color? category8,
    Color? category9,
    Color? category10,
    Color? habitText,
  }) {
    return OwnColors(
      contribution0: contribution0 ?? this.contribution0,
      contribution1: contribution1 ?? this.contribution1,
      contribution2: contribution2 ?? this.contribution2,
      contribution3: contribution3 ?? this.contribution3,
      contribution4: contribution4 ?? this.contribution4,
      contribution5: contribution5 ?? this.contribution5,
      contributionDefault: contributionDefault ?? this.contributionDefault,
      category1: category1 ?? this.category1,
      category2: category2 ?? this.category2,
      category3: category3 ?? this.category3,
      category4: category4 ?? this.category4,
      category5: category5 ?? this.category5,
      category6: category6 ?? this.category6,
      category7: category7 ?? this.category7,
      category8: category8 ?? this.category8,
      category9: category9 ?? this.category9,
      category10: category10 ?? this.category10,
      habitText: habitText ?? this.habitText,
    );
  }

  /// Linearly interpolate between two [OwnColors] objects.
  @override
  ThemeExtension<OwnColors> lerp(ThemeExtension<OwnColors>? other, double t) {
    if (other is! OwnColors) {
      return this;
    }
    return OwnColors(
      contribution0: Color.lerp(contribution0, other.contribution0, t)!,
      contribution1: Color.lerp(contribution1, other.contribution1, t)!,
      contribution2: Color.lerp(contribution2, other.contribution2, t)!,
      contribution3: Color.lerp(contribution3, other.contribution3, t)!,
      contribution4: Color.lerp(contribution4, other.contribution4, t)!,
      contribution5: Color.lerp(contribution5, other.contribution5, t)!,
      contributionDefault:
          Color.lerp(contributionDefault, other.contributionDefault, t)!,
      category1: Color.lerp(category1, other.category1, t)!,
      category2: Color.lerp(category2, other.category2, t)!,
      category3: Color.lerp(category3, other.category3, t)!,
      category4: Color.lerp(category4, other.category4, t)!,
      category5: Color.lerp(category5, other.category5, t)!,
      category6: Color.lerp(category6, other.category6, t)!,
      category7: Color.lerp(category7, other.category7, t)!,
      category8: Color.lerp(category8, other.category8, t)!,
      category9: Color.lerp(category9, other.category9, t)!,
      category10: Color.lerp(category10, other.category10, t)!,
      habitText: Color.lerp(habitText, other.habitText, t)!,
    );
  }
}
