part of 'theme.dart';

extension TextThemeContext on BuildContext {
  /// The text theme for the current theme.
  TextTheme get textTheme => theme.textTheme;

  @Deprecated('Use displayLarge instead')
  TextStyle? get headline1 => textTheme.displayLarge;

  @Deprecated('Use displayMedium instead')
  TextStyle? get headline2 => textTheme.displayMedium;

  @Deprecated('Use displaySmall instead')
  TextStyle? get headline3 => textTheme.displaySmall;

  @Deprecated('Use headlineMedium instead')
  TextStyle? get headline4 => textTheme.headlineMedium;

  @Deprecated('Use headlineSmall instead')
  TextStyle? get headline5 => textTheme.headlineSmall;

  @Deprecated('Use headlineLarge instead')
  TextStyle? get headline6 => textTheme.headlineLarge;

  @Deprecated('Use titleMedium instead')
  TextStyle? get subtitle1 => textTheme.titleMedium;

  @Deprecated('Use titleSmall instead')
  TextStyle? get subtitle2 => textTheme.titleSmall;

  @Deprecated('Use bodyLarge instead')
  TextStyle? get bodyText1 => textTheme.bodyLarge;

  @Deprecated('Use bodyMedium instead')
  TextStyle? get bodyText2 => textTheme.bodyMedium;

  @Deprecated('Use bodySmall instead')
  TextStyle? get caption => textTheme.bodySmall;

  @Deprecated('Use labelLarge instead')
  TextStyle? get button => textTheme.labelLarge;

  @Deprecated('Use labelSmall instead')
  TextStyle? get overline => textTheme.labelSmall;

  /// Largest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Middle size of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Smallest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Largest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Middle size of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Smallest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Largest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Middle size of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Smallest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Largest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Smallest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Largest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  ///
  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Middle size of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Smallest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get labelSmall => textTheme.labelSmall;
}

extension PrimaryTextThemeContext on BuildContext {
  /// A text theme that contrasts with the primary color.
  TextTheme get primaryTextTheme => theme.primaryTextTheme;

  @Deprecated('Use primaryDisplayLarge instead')
  TextStyle? get primaryHeadline1 => primaryTextTheme.displayLarge;

  @Deprecated('Use primaryDisplayMedium instead')
  TextStyle? get primaryHeadline2 => primaryTextTheme.displayMedium;

  @Deprecated('Use primaryDisplaySmall instead')
  TextStyle? get primaryHeadline3 => primaryTextTheme.displaySmall;

  @Deprecated('Use primaryHeadlineMedium instead')
  TextStyle? get primaryHeadline4 => primaryTextTheme.headlineMedium;

  @Deprecated('Use primaryHeadlineSmall instead')
  TextStyle? get primaryHeadline5 => primaryTextTheme.headlineSmall;

  @Deprecated('Use primaryTitleLarge instead')
  TextStyle? get primaryHeadline6 => primaryTextTheme.titleLarge;

  @Deprecated('Use primaryTitleMedium instead')
  TextStyle? get primarySubtitle1 => primaryTextTheme.titleMedium;

  @Deprecated('Use primaryTitleSmall instead')
  TextStyle? get primarySubtitle2 => primaryTextTheme.titleSmall;

  @Deprecated('Use primaryBodyLarge instead')
  TextStyle? get primaryBodyText1 => primaryTextTheme.bodyLarge;

  @Deprecated('Use primaryBodyMedium instead')
  TextStyle? get primaryBodyText2 => primaryTextTheme.bodyMedium;

  @Deprecated('Use primaryBodySmall instead')
  TextStyle? get primaryCaption => primaryTextTheme.bodySmall;

  @Deprecated('Use primaryLabelLarge instead')
  TextStyle? get primaryButton => primaryTextTheme.labelLarge;

  @Deprecated('Use primaryLabelSmall instead')
  TextStyle? get primaryOverline => primaryTextTheme.labelSmall;

  /// Largest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get primaryDisplayLarge => primaryTextTheme.displayLarge;

  /// Middle size of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get primaryDisplayMedium => primaryTextTheme.displayMedium;

  /// Smallest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get primaryDisplaySmall => primaryTextTheme.displaySmall;

  /// Largest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get primaryHeadlineLarge => primaryTextTheme.headlineLarge;

  /// Middle size of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get primaryHeadlineMedium => primaryTextTheme.headlineMedium;

  /// Smallest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get primaryHeadlineSmall => primaryTextTheme.headlineSmall;

  /// Largest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get primaryTitleLarge => primaryTextTheme.titleLarge;

  /// Middle size of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get primaryTitleMedium => primaryTextTheme.titleMedium;

  /// Smallest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get primaryTitleSmall => primaryTextTheme.titleSmall;

  /// Largest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get primaryBodyLarge => primaryTextTheme.bodyLarge;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get primaryBodyMedium => primaryTextTheme.bodyMedium;

  /// Smallest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get primaryBodySmall => primaryTextTheme.bodySmall;

  /// Largest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  ///
  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  TextStyle? get primaryLabelLarge => primaryTextTheme.labelLarge;

  /// Middle size of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get primaryLabelMedium => primaryTextTheme.labelMedium;

  /// Smallest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get primaryLabelSmall => primaryTextTheme.labelSmall;
}
