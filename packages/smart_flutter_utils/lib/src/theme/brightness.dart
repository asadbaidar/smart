import 'package:flutter/material.dart';

extension SmartBrightness on Brightness {
  Brightness get inverse =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;

  static Brightness value(bool isDark) =>
      isDark ? Brightness.dark : Brightness.light;

  bool get isLight => this == Brightness.light;

  bool get isDark => this == Brightness.dark;
}

extension BrightnessContext on BuildContext {
  bool get isSystemDark =>
      ThemeMode.system == ThemeMode.dark ||
      MediaQuery.platformBrightnessOf(this) == Brightness.dark;

  Brightness get systemBrightness => SmartBrightness.value(isSystemDark);
}
