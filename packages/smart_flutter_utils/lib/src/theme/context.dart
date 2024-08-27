import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  /// The icon theme data from the closest instance
  IconThemeData get iconTheme => IconTheme.of(this);

  /// The icon color from the closest instance
  Color? get iconColor => iconTheme.color;
}

extension MaterialLocalizationsContext on BuildContext {
  /// The localized strings for the current locale.
  MaterialLocalizations get localizations => MaterialLocalizations.of(this);
}
