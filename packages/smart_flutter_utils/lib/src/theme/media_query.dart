part of 'theme.dart';

extension MediaQueryContext on BuildContext {
  /// Returns the [MediaQueryData] for the current [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  /// similar to [MediaQuery.of(context).viewInsets]
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
}
