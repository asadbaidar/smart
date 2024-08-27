import 'package:flutter/widgets.dart';
import 'package:smart_flutter_utils/src/theme/theme.dart';

extension WidgetUtils on BuildContext {
  /// Full screen height constraint below the status bar
  BoxConstraints get fullscreenNoStatusBar => BoxConstraints(
        maxHeight: screenSize.height - padding.top,
      );

  /// Full screen height constraint below the app bar
  BoxConstraints get fullscreenNoAppBar => BoxConstraints(
        maxHeight: screenSize.height - padding.top - toolbarHeight,
      );

  /// Returns the position of the widget in the overlay
  RelativeRect getPosition({Offset? offset}) {
    final vOffset = offset ?? Offset.zero;
    final RenderBox widget = findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(this).overlay!.context.findRenderObject()! as RenderBox;
    return RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(vOffset, ancestor: overlay),
        widget.localToGlobal(
          widget.size.bottomRight(Offset.zero) + vOffset,
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
  }

  /// Compute the number of lines for the given text
  int getTextLines(
    String text, {
    TextStyle? style,
    required double maxWidth,
  }) {
    final span = TextSpan(text: text, style: style);
    final painter = TextPainter(text: span, textDirection: textDirection);
    painter.layout(maxWidth: maxWidth);
    return painter.computeLineMetrics().length;
  }
}
