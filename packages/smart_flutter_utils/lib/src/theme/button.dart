part of 'theme.dart';

extension ButtonThemeContext on BuildContext {
  /// Elevated Button Theme Style
  ButtonStyle? get elevatedButton => theme.elevatedButtonTheme.style;

  /// Elevated Button Foreground Color
  Color? get elevatedButtonForegroundColor =>
      elevatedButton?.foregroundColor?.normal ?? secondaryColor.contrast;

  /// Outlined Button Theme Style
  ButtonStyle? get outlinedButton => theme.outlinedButtonTheme.style;

  /// Outlined Button Foreground Color
  Color? get outlinedButtonForegroundColor =>
      outlinedButton?.foregroundColor?.normal ?? secondaryColor;

  /// Text Button Theme Style
  ButtonStyle? get textButton => theme.textButtonTheme.style;

  /// Text Button Foreground Color
  Color? get textButtonForegroundColor =>
      textButton?.foregroundColor?.normal ?? secondaryColor;
}
