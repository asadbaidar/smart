import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

part 'app_bar.dart';
part 'brightness.dart';
part 'color.dart';
part 'directionality.dart';
part 'media_query.dart';
part 'platform.dart';
part 'bottom_bar.dart';
part 'button.dart';
part 'list_tile.dart';
part 'material_state.dart';
part 'text.dart';

extension ThemeContext on BuildContext {
  /// A set of thirteen colors that can be used to configure the
  /// color properties of most components.
  ColorScheme get colorScheme => theme.colorScheme;

  /// The background color for primary parts of the app (app bars, tab bars, etc)
  Color get primaryColor => theme.primaryColor;

  /// An accent color that, when used sparingly, calls attention to parts
  /// of your app.
  Color get secondaryColor => colorScheme.secondary;

  /// The color to use for hint text or placeholder text, e.g. in
  /// [TextField] fields.
  Color get hintColor => theme.hintColor;

  /// The highlight color used during ink splash animations or to
  /// indicate an item in a menu is selected.
  Color get highlightColor => theme.highlightColor;

  /// The color of [Divider]s and [PopupMenuDivider]s, also used
  /// between [ListTile]s, between rows in [DataTable]s, and so forth.
  Color get dividerColor => theme.dividerColor;

  /// The default color of [MaterialType.canvas] [Material].
  Color get canvasColor => theme.canvasColor;

  /// A color that contrasts with the [primaryColor], e.g. used as the
  /// remaining part of a progress bar.
  Color get backgroundColor => theme.backgroundColor;

  /// The default color of the [Material] that underlies the [Scaffold]. The
  /// background color for a typical material app or a page within the app.
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// An icon theme that contrasts with the card and canvas colors.
  IconThemeData get iconTheme => theme.iconTheme;

  /// The default color for icons.
  Color? get iconColor => iconTheme.color;
}

extension MaterialLocalizationsContext on BuildContext {
  /// The localized strings for the current locale.
  MaterialLocalizations get localizations => MaterialLocalizations.of(this);
}