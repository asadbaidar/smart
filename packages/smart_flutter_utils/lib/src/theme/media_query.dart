part of 'theme.dart';

extension MediaQueryContext on BuildContext {
  /// Returns the [MediaQueryData] for the current [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.viewPaddingOf(context)]
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// similar to [MediaQuery.viewInsetsOf(context)]
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// similar to [MediaQuery.sizeOf(context)]
  Size get screenSize => MediaQuery.sizeOf(this);

  /// similar to [MediaQuery.sizeOf(context).width]
  double get screenWidth => screenSize.width;

  /// similar to [MediaQuery.sizeOf(context).height]
  double get screenHeight => screenSize.height;

  /// similar to [MediaQuery.sizeOf(context).shortestSide]
  double get screenShortestSide => screenSize.shortestSide; 
}
