import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

extension ButtonThemeContext on BuildContext {
  /// Elevated Button Theme Style
  ButtonStyle? get elevatedButton => theme.elevatedButtonTheme.style;

  /// Outlined Button Theme Style
  ButtonStyle? get outlinedButton => theme.outlinedButtonTheme.style;

  /// Text Button Theme Style
  ButtonStyle? get textButton => theme.textButtonTheme.style;
}
