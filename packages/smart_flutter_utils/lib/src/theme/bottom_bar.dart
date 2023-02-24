part of 'theme.dart';

extension BottomBarThemeContext on BuildContext {
  /// A theme for customizing the shape, elevation, and color of a [BottomAppBar].
  BottomAppBarTheme get bottomBarTheme => theme.bottomAppBarTheme;

  /// A theme for customizing the appearance and layout of [BottomNavigationBar]
  /// widgets.
  BottomNavigationBarThemeData get bottomNavBarTheme =>
      theme.bottomNavigationBarTheme;

  /// The background color for bottom parts of the app i.e. bottom bars
  Color get bottomBarColor => bottomBarTheme.color ?? backgroundColor;
}
