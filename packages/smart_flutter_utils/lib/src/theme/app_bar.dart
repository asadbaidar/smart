import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

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

  /// [AppBar.toolbarHeight].
  /// Depending on platform, Defaults to [systemToolbarHeight].
  double get toolbarHeight => appBarTheme.toolbarHeight ?? systemToolbarHeight;
}
