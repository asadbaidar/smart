part of 'theme.dart';

extension DirectionalityContext on BuildContext {
  /// Returns the [Directionality] for the current [BuildContext].
  TextDirection get textDirection => Directionality.of(this);

  /// true if [textDirection] is [TextDirection.ltr]
  bool get isLTR => textDirection.isLTR;

  /// true if [textDirection] is [TextDirection.rtl]
  bool get isRTL => textDirection.isRTL;
}

extension TextDirectionX on TextDirection {
  /// true if [TextDirection.ltr]
  bool get isLTR => this == TextDirection.ltr;

  /// true if [TextDirection.rtl]
  bool get isRTL => this == TextDirection.rtl;
}
