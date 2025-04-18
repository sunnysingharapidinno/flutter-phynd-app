import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final Map<String, Color> colors;

  const AppTheme(this.colors);

  Color get(String key) => colors[key] ?? Colors.black;

  @override
  AppTheme copyWith({Map<String, Color>? colors}) {
    return AppTheme({...this.colors, ...?colors});
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    final mergedKeys = {...colors.keys, ...other.colors.keys};
    final lerped = <String, Color>{};

    for (final key in mergedKeys) {
      final a = colors[key];
      final b = other.colors[key];
      if (a != null && b != null) {
        lerped[key] = Color.lerp(a, b, t) ?? a;
      } else {
        lerped[key] = a ?? b ?? Colors.black;
      }
    }

    return AppTheme(lerped);
  }
}
