part of 'theme.dart';

extension ColorBrightness on Color {
  /// Returns if the luminance of the color is dark.
  bool get isDark => (299 * red + 587 * green + 114 * blue) / 1000 < 162;

  /// Returns the pure white/black color contrast to its luminance.
  Color get contrast => isDark ? Colors.white : Colors.black;

  /// Returns the brightness of the color based on its luminance.
  Brightness get brightness => isDark ? Brightness.light : Brightness.dark;

  /// Returns the default light/dark themes based on its luminance.
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();

  /// Returns the darker shade of the color.
  Color get darker => withBlue(max(blue - 50, 0))
      .withGreen(max(green - 50, 0))
      .withRed(max(red - 50, 0));
}

extension ColorOpacity on Color {
  /// Returns the color with 5% opacity.
  Color get highlighted => withOpacity(0.05);

  /// Returns the color with 15% opacity.
  Color get lighted => withOpacity(0.15);

  /// Returns the color with 20% opacity.
  Color get dimmed => withOpacity(0.2);

  /// Returns the color with 30% opacity.
  Color get disabled => withOpacity(0.3);

  /// Returns the color with 34% opacity.
  Color get hinted => withOpacity(0.34);

  /// Returns the color with 55% opacity.
  Color get subbed => withOpacity(0.55);

  /// Returns the color with 65% opacity.
  Color get pressed => withOpacity(0.65);

  /// Returns the color with 72.7% opacity.
  Color get focused => withOpacity(0.727);

  /// Returns the color with 90% opacity.
  Color get activated => withOpacity(0.9);

  /// Returns the color with 95% opacity.
  Color get translucent => withOpacity(0.95);

  /// Returns the color with 100% opacity.
  Color get normal => withOpacity(1);
}

extension MaterialColors on Color {
  /// Returns if material color. Null otherwise.
  MaterialColor? get material => $cast(this);

  /// Returns if material accent color. Null otherwise.
  MaterialAccentColor? get materialAccent => $cast(this);
}

extension BorderSideColor on Color {
  /// Returns the border side with the color.
  BorderSide? get borderSide => BorderSide(color: this);
}
