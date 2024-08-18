part of 'theme.dart';

extension ColorBrightness on Color {
  /// Returns if the luminance of the color is dark.
  bool get isDark => (299 * red + 587 * green + 114 * blue) / 1000 < 162;

  /// Returns if the luminance of the color is light.
  bool get isLight => !isDark;

  /// Returns the color if luminance of the color is dark. Null otherwise.
  Color? get notDark => isDark ? null : this;

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

extension ContextColorScheme on BuildContext {
  Color get primary => colorScheme.primary;
  Color get surfaceTint => colorScheme.surfaceTint;
  Color get onPrimary => colorScheme.onPrimary;
  Color get primaryContainer => colorScheme.primaryContainer;
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;
  Color get secondary => colorScheme.secondary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get secondaryContainer => colorScheme.secondaryContainer;
  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;
  Color get tertiary => colorScheme.tertiary;
  Color get onTertiary => colorScheme.onTertiary;
  Color get tertiaryContainer => colorScheme.tertiaryContainer;
  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;
  Color get error => colorScheme.error;
  Color get onError => colorScheme.onError;
  Color get errorContainer => colorScheme.errorContainer;
  Color get onErrorContainer => colorScheme.onErrorContainer;
  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;
  Color get outline => colorScheme.outline;
  Color get outlineVariant => colorScheme.outlineVariant;
  Color get shadow => colorScheme.shadow;
  Color get scrim => colorScheme.scrim;
  Color get inverseSurface => colorScheme.inverseSurface;
  Color get onInverseSurface => colorScheme.onInverseSurface;
  Color get inversePrimary => colorScheme.inversePrimary;
  Color get primaryFixed => colorScheme.primaryFixed;
  Color get onPrimaryFixed => colorScheme.onPrimaryFixed;
  Color get primaryFixedDim => colorScheme.primaryFixedDim;
  Color get onPrimaryFixedVariant => colorScheme.onPrimaryFixedVariant;
  Color get secondaryFixed => colorScheme.secondaryFixed;
  Color get onSecondaryFixed => colorScheme.onSecondaryFixed;
  Color get secondaryFixedDim => colorScheme.secondaryFixedDim;
  Color get onSecondaryFixedVariant => colorScheme.onSecondaryFixedVariant;
  Color get tertiaryFixed => colorScheme.tertiaryFixed;
  Color get onTertiaryFixed => colorScheme.onTertiaryFixed;
  Color get tertiaryFixedDim => colorScheme.tertiaryFixedDim;
  Color get onTertiaryFixedVariant => colorScheme.onTertiaryFixedVariant;
  Color get surfaceDim => colorScheme.surfaceDim;
  Color get surfaceBright => colorScheme.surfaceBright;
  Color get surfaceContainerLowest => colorScheme.surfaceContainerLowest;
  Color get surfaceContainerLow => colorScheme.surfaceContainerLow;
  Color get surfaceContainer => colorScheme.surfaceContainer;
  Color get surfaceContainerHigh => colorScheme.surfaceContainerHigh;
  Color get surfaceContainerHighest => colorScheme.surfaceContainerHighest;
}

extension TextStyleColor on TextStyle {
  TextStyle withColor(Color? color) => copyWith(color: color);

  TextStyle primary(BuildContext context) => withColor(context.primary);

  TextStyle onPrimary(BuildContext context) => withColor(context.onPrimary);

  TextStyle primaryContainer(BuildContext context) =>
      withColor(context.primaryContainer);

  TextStyle onPrimaryContainer(BuildContext context) =>
      withColor(context.onPrimaryContainer);

  TextStyle secondary(BuildContext context) => withColor(context.secondary);

  TextStyle onSecondary(BuildContext context) => withColor(context.onSecondary);

  TextStyle secondaryContainer(BuildContext context) =>
      withColor(context.secondaryContainer);

  TextStyle onSecondaryContainer(BuildContext context) =>
      withColor(context.onSecondaryContainer);

  TextStyle tertiary(BuildContext context) => withColor(context.tertiary);

  TextStyle onTertiary(BuildContext context) => withColor(context.onTertiary);

  TextStyle tertiaryContainer(BuildContext context) =>
      withColor(context.tertiaryContainer);

  TextStyle onTertiaryContainer(BuildContext context) =>
      withColor(context.onTertiaryContainer);

  TextStyle error(BuildContext context) => withColor(context.error);

  TextStyle onError(BuildContext context) => withColor(context.onError);

  TextStyle errorContainer(BuildContext context) =>
      withColor(context.errorContainer);

  TextStyle onErrorContainer(BuildContext context) =>
      withColor(context.onErrorContainer);

  TextStyle surface(BuildContext context) => withColor(context.surface);

  TextStyle onSurface(BuildContext context) => withColor(context.onSurface);

  TextStyle onSurfaceVariant(BuildContext context) =>
      withColor(context.onSurfaceVariant);

  TextStyle outline(BuildContext context) => withColor(context.outline);

  TextStyle outlineVariant(BuildContext context) =>
      withColor(context.outlineVariant);

  TextStyle shadow(BuildContext context) => withColor(context.shadow);

  TextStyle scrim(BuildContext context) => withColor(context.scrim);

  TextStyle inverseSurface(BuildContext context) =>
      withColor(context.inverseSurface);

  TextStyle onInverseSurface(BuildContext context) =>
      withColor(context.onInverseSurface);

  TextStyle inversePrimary(BuildContext context) =>
      withColor(context.inversePrimary);

  TextStyle primaryFixed(BuildContext context) =>
      withColor(context.primaryFixed);

  TextStyle onPrimaryFixed(BuildContext context) =>
      withColor(context.onPrimaryFixed);

  TextStyle primaryFixedDim(BuildContext context) =>
      withColor(context.primaryFixedDim);

  TextStyle onPrimaryFixedVariant(BuildContext context) =>
      withColor(context.onPrimaryFixedVariant);

  TextStyle secondaryFixed(BuildContext context) =>
      withColor(context.secondaryFixed);

  TextStyle onSecondaryFixed(BuildContext context) =>
      withColor(context.onSecondaryFixed);

  TextStyle secondaryFixedDim(BuildContext context) =>
      withColor(context.secondaryFixedDim);

  TextStyle onSecondaryFixedVariant(BuildContext context) =>
      withColor(context.onSecondaryFixedVariant);

  TextStyle tertiaryFixed(BuildContext context) =>
      withColor(context.tertiaryFixed);

  TextStyle onTertiaryFixed(BuildContext context) =>
      withColor(context.onTertiaryFixed);

  TextStyle tertiaryFixedDim(BuildContext context) =>
      withColor(context.tertiaryFixedDim);

  TextStyle onTertiaryFixedVariant(BuildContext context) =>
      withColor(context.onTertiaryFixedVariant);

  TextStyle surfaceDim(BuildContext context) => withColor(context.surfaceDim);

  TextStyle surfaceBright(BuildContext context) =>
      withColor(context.surfaceBright);

  TextStyle surfaceContainerLowest(BuildContext context) =>
      withColor(context.surfaceContainerLowest);

  TextStyle surfaceContainerLow(BuildContext context) =>
      withColor(context.surfaceContainerLow);

  TextStyle surfaceContainer(BuildContext context) =>
      withColor(context.surfaceContainer);

  TextStyle surfaceContainerHigh(BuildContext context) =>
      withColor(context.surfaceContainerHigh);

  TextStyle surfaceContainerHighest(BuildContext context) =>
      withColor(context.surfaceContainerHighest);
}
