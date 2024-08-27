import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

extension BottomBarThemeContext on BuildContext {
  /// A theme for customizing the shape, elevation, and color of a [BottomAppBar].
  BottomAppBarTheme get bottomBarTheme => theme.bottomAppBarTheme;

  /// A theme for customizing the appearance and layout of [BottomNavigationBar]
  /// widgets.
  BottomNavigationBarThemeData get bottomNavBarTheme =>
      theme.bottomNavigationBarTheme;
}
