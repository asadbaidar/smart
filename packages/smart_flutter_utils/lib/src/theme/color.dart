import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

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

  /// Returns the color with 5% opacity.
  Color get opacity5 => withOpacity(0.05);

  /// Returns the color with 10% opacity.
  Color get opacity10 => withOpacity(0.1);

  /// Returns the color with 15% opacity.
  Color get opacity15 => withOpacity(0.15);

  /// Returns the color with 20% opacity.
  Color get opacity20 => withOpacity(0.2);

  /// Returns the color with 25% opacity.
  Color get opacity25 => withOpacity(0.25);

  /// Returns the color with 30% opacity.
  Color get opacity30 => withOpacity(0.3);

  /// Returns the color with 35% opacity.
  Color get opacity35 => withOpacity(0.35);

  /// Returns the color with 40% opacity.
  Color get opacity40 => withOpacity(0.4);

  /// Returns the color with 45% opacity.
  Color get opacity45 => withOpacity(0.45);

  /// Returns the color with 50% opacity.
  Color get opacity50 => withOpacity(0.5);

  /// Returns the color with 55% opacity.
  Color get opacity55 => withOpacity(0.55);

  /// Returns the color with 60% opacity.
  Color get opacity60 => withOpacity(0.6);

  /// Returns the color with 65% opacity.
  Color get opacity65 => withOpacity(0.65);

  /// Returns the color with 70% opacity.
  Color get opacity70 => withOpacity(0.7);

  /// Returns the color with 75% opacity.
  Color get opacity75 => withOpacity(0.75);

  /// Returns the color with 80% opacity.
  Color get opacity80 => withOpacity(0.8);

  /// Returns the color with 85% opacity.
  Color get opacity85 => withOpacity(0.85);

  /// Returns the color with 90% opacity.
  Color get opacity90 => withOpacity(0.9);

  /// Returns the color with 95% opacity.
  Color get opacity95 => withOpacity(0.95);

  /// Returns the color with 100% opacity.
  Color get opacity100 => withOpacity(1);
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
  /// A set of thirteen colors that can be used to configure the
  /// color properties of most components.
  ColorScheme get colorScheme => theme.colorScheme;

  /// The color to use for hint text or placeholder text, e.g. in
  /// [TextField] fields.
  Color get hintColor => theme.hintColor;

  /// The default color of the [Material] that underlies the [Scaffold]. The
  /// background color for a typical material app or a page within the app.
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

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

extension SmartColorString on String {
  /// Returns random color seeded with [hashCode] of the string
  Color get color => SmartColors.random(this);
}

class SmartColors {
  const SmartColors._();

  static const charcoal = Color(0xff252525);
  static const livid = Color(0xff395b74);
  static const lividLight = Color(0xff78909c);
  static const lividDark = Color(0xff2d495e);
  static const amber = Color(0xffffca28);
  static const orange = Color(0xffe5680f);
  static const orangeEve = Color(0xffe84d01);
  static const brown = Color(0xff795548);
  static const red = Color(0xffd50000);
  static const redLight = Color(0xffef5350);
  static const redDark = Color(0xffb40000);
  static const cherry = Color(0xffc72349);
  static const cherryDark = Color(0xffaf1e40);
  static const pink = Color(0xffad1457);
  static const pinkLight = Color(0xffec407a);
  static const pinkDark = Color(0xff790e3c);
  static const sky = Color(0xff1E88E5);
  static const skyLight = Color(0xff42a5f5);
  static const blue = Color(0xff1769aa);
  static const blueDark = Color(0xff14578c);
  static const indigoLight = Color(0xff5c6bc0);
  static const indigoDark = Color(0xff2c387e);
  static const purple = Color(0xff9c27b0);
  static const purpleDark = Color(0xff6d1b7b);
  static const purpleEve = Color(0xff723b48);
  static const violet = Color(0xff673ab7);
  static const violetDark = Color(0xff482880);
  static const plum = Color(0xff625b91);
  static const plumDark = Color(0xff514a78);
  static const teal = Color(0xff039694);
  static const tealDark = Color(0xff006974);
  static const green = Color(0xff0F9D58);
  static const greenLight = Color(0xff7cb342);
  static const greenLighter = Color(0xff66bb6a);
  static const greenDark = Color(0xff0d844a);

  static Color random(String seed) => list[seed.random(list.length)];

  static const list = [
    charcoal,
    Colors.lightBlueAccent,
    livid,
    Colors.teal,
    amber,
    pinkDark,
    orange,
    Colors.indigoAccent,
    pinkLight,
    Colors.lightBlue,
    redLight,
    Colors.green,
    cherry,
    Colors.lightGreen,
    purpleEve,
    greenDark,
    Colors.blueAccent,
    violet,
    Colors.blueGrey,
    greenLighter,
    Colors.deepOrangeAccent,
    cherryDark,
    lividDark,
    Colors.blue,
    pink,
    skyLight,
    Colors.greenAccent,
    indigoDark,
    green,
    Colors.pinkAccent,
    plum,
    Colors.orange,
    indigoLight,
    Colors.pink,
    orangeEve,
    Colors.amber,
    sky,
    red,
    Colors.orangeAccent,
    purpleDark,
    greenLight,
    blue,
    Colors.deepPurple,
    redDark,
    Colors.purple,
    plumDark,
    purple,
    teal,
    Colors.indigo,
    violetDark,
    tealDark,
    Colors.purpleAccent,
    blueDark,
    lividLight,
    Colors.deepPurpleAccent,
    brown,
  ];
}
