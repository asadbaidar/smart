part of 'theme.dart';

extension ListTileThemeContext on BuildContext {
  /// A theme for customizing the appearance of ListTile widgets
  ListTileThemeData get tileTheme => theme.listTileTheme;

  /// Overrides the default value of [ListTile.iconColor].
  Color? get tileIconColor => tileTheme.iconColor;

  /// Overrides the default value of [ListTile.tileColor].
  Color? get tileColor => tileTheme.tileColor;
}
