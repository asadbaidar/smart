part of 'theme.dart';

extension TextThemeContext on BuildContext {
  /// The text theme for the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// Extremely large text.
  TextStyle? get headline1 => textTheme.headline1;

  /// Very, very large text.
  ///
  /// Used for the date in the dialog shown by [showDatePicker].
  TextStyle? get headline2 => textTheme.headline2;

  /// Very large text.
  TextStyle? get headline3 => textTheme.headline3;

  /// Large text.
  TextStyle? get headline4 => textTheme.headline4;

  /// Used for large text in dialogs (e.g., the month and year in the dialog
  /// shown by [showDatePicker]).
  TextStyle? get headline5 => textTheme.headline5;

  /// Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
  /// and [AlertDialog.title]).
  TextStyle? get headline6 => textTheme.headlineLarge;

  /// Used for the primary text in lists (e.g., [ListTile.title]).
  TextStyle? get subtitle1 => textTheme.subtitle1;

  /// For medium emphasis text that's a little smaller than [subtitle1].
  TextStyle? get subtitle2 => textTheme.subtitle2;

  /// Used for emphasizing text that would otherwise be [bodyText2].
  TextStyle? get bodyText1 => textTheme.bodyText1;

  /// The default text style for [Material].
  TextStyle? get bodyText2 => textTheme.bodyText2;

  /// Used for auxiliary text associated with images.
  TextStyle? get caption => textTheme.caption;

  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  TextStyle? get button => textTheme.button;

  /// The smallest style.
  ///
  /// Typically used for captions or to introduce a (larger) headline.
  TextStyle? get overline => textTheme.overline;
}

extension PrimaryTextThemeContext on BuildContext {
  /// A text theme that contrasts with the primary color.
  TextTheme get primaryTextTheme => theme.primaryTextTheme;

  /// Extremely large text that contrasts with the primary color.
  TextStyle? get primaryHeadline1 => primaryTextTheme.headline1;

  /// Very, very large text that contrasts with the primary color.
  ///
  /// Used for the date in the dialog shown by [showDatePicker].
  TextStyle? get primaryHeadline2 => primaryTextTheme.headline2;

  /// Very large text that contrasts with the primary color.
  TextStyle? get primaryHeadline3 => primaryTextTheme.headline3;

  /// Large text that contrasts with the primary color.
  TextStyle? get primaryHeadline4 => primaryTextTheme.headline4;

  /// Used for large text in dialogs (e.g., the month and year in the dialog
  /// shown by [showDatePicker]) that contrasts with the primary color.
  TextStyle? get primaryHeadline5 => primaryTextTheme.headline5;

  /// Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
  /// and [AlertDialog.title]) that contrasts with the primary color.
  TextStyle? get primaryHeadline6 => primaryTextTheme.headline6;

  /// Used for the primary text in lists (e.g., [ListTile.title]) that
  /// contrasts with the primary color.
  TextStyle? get primarySubtitle1 => primaryTextTheme.subtitle1;

  /// For medium emphasis text that's a little smaller than [subtitle1] and
  /// contrasts with the primary color.
  TextStyle? get primarySubtitle2 => primaryTextTheme.subtitle2;

  /// Used for emphasizing text that would otherwise be [bodyText2] and
  /// contrasts with the primary color.
  TextStyle? get primaryBodyText1 => primaryTextTheme.bodyText1;

  /// The default text style for [Material] that contrasts with the
  /// primary color.
  TextStyle? get primaryBodyText2 => primaryTextTheme.bodyText2;

  /// Used for auxiliary text associated with images that contrasts
  /// with the primary color.
  TextStyle? get primaryCaption => primaryTextTheme.caption;

  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton]
  /// that contrasts with the primary color.
  TextStyle? get primaryButton => primaryTextTheme.button;

  /// The smallest style that contrasts with the primary color.
  ///
  /// Typically used for captions or to introduce a (larger) headline.
  TextStyle? get primaryOverline => primaryTextTheme.overline;
}
