part of 'theme.dart';

extension AppBarThemeContext on BuildContext {
  AppBarTheme get appBarTheme => theme.appBarTheme;

  /// Whether the title should be centered.
  /// Overrides or returns the default value for [AppBar.centerTitle].
  bool? appBarCenterTitle(bool? centerTitle, {List<Widget>? actions}) {
    if (centerTitle != null) return centerTitle;
    if (appBarTheme.centerTitle != null) return appBarTheme.centerTitle;
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return actions == null || actions.length < 2;
      default:
        return false;
    }
  }

  /// Platform based app bar height.
  /// iOS: [kMinInteractiveDimensionCupertino]
  /// Android: [kToolbarHeight].
  double get systemToolbarHeight =>
      isIOS ? kMinInteractiveDimensionCupertino : kToolbarHeight;

  /// [AppBar.elevation]. Defaults to 1.0.
  double get appBarElevation => appBarTheme.elevation ?? 1.0;

  /// [AppBar.toolbarHeight].
  /// Depending on platform, Defaults to [systemToolbarHeight].
  double get toolbarHeight => appBarTheme.toolbarHeight ?? systemToolbarHeight;

  /// [AppBar.shadowColor]. Defaults to [Colors.black].
  Color get appBarShadowColor => appBarTheme.shadowColor ?? Colors.black;

  /// [AppBar.backgroundColor]. Defaults to [Colors.white].
  Color get appBarBackgroundColor =>
      appBarTheme.backgroundColor ?? Colors.white;

  /// [AppBar.foregroundColor]. Defaults to [primaryColor].
  Color get appBarForegroundColor =>
      appBarTheme.foregroundColor ?? primaryColor;

  /// [AppBar.titleTextStyle]. Defaults to [primaryHeadline6].
  TextStyle? get titleTextStyle =>
      appBarTheme.titleTextStyle ??
      primaryHeadline6?.copyWith(color: Colors.black);

  /// [AppBar.toolbarTextStyle]. Defaults to [primaryBodyText1].
  TextStyle? get toolbarTextStyle =>
      appBarTheme.toolbarTextStyle ??
      primaryBodyText1?.copyWith(color: primaryColor);

  /// An icon theme that contrasts with the primary color.
  IconThemeData get primaryIconTheme => theme.primaryIconTheme;

  /// The default color for primary icons.
  Color? get primaryIconColor => primaryIconTheme.color;

  /// An action icon theme that contrasts with the primary color.
  IconThemeData get primaryActionIconTheme =>
      appBarTheme.actionsIconTheme ?? primaryIconTheme;

  /// The default color for primary action icons.
  Color? get primaryActionIconColor => primaryActionIconTheme.color;
}
