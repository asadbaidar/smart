part of 'theme.dart';

extension BottomBarThemeContext on BuildContext {
  /// A theme for customizing the shape, elevation, and color of a [BottomAppBar].
  BottomAppBarTheme get bottomBarTheme => theme.bottomAppBarTheme;

  /// A theme for customizing the appearance and layout of [BottomNavigationBar]
  /// widgets.
  BottomNavigationBarThemeData get bottomNavBarTheme =>
      theme.bottomNavigationBarTheme;

  /// The background color for bottom parts of the app (bottom bars, snack bars, etc)
  Color get bottomBarColor => theme.bottomAppBarColor;
}
