import 'package:flutter/cupertino.dart';

/// A widget that combines [CupertinoButton] and [GestureDetector] to provide
/// a clickable widget with a custom cursor.
class Clickable extends MouseRegion {
  Clickable({
    bool enabled = true,
    bool cupertino = false,
    double pressedOpacity = 0.4,
    VoidCallback? onTap,
    Widget? child,
    super.key,
  }) : super(
          cursor: enabled && onTap != null
              ? WidgetStateMouseCursor.clickable
              : SystemMouseCursors.basic,
          child: cupertino
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  pressedOpacity: pressedOpacity,
                  onPressed: enabled ? onTap : null,
                  child: child ?? const SizedBox(),
                )
              : GestureDetector(
                  onTap: enabled ? onTap : null,
                  child: child,
                ),
        );

  /// Creates a [Clickable] with a [CupertinoButton].
  Clickable.cupertino({
    bool enabled = true,
    double pressedOpacity = 0.4,
    VoidCallback? onTap,
    Widget? child,
    Key? key,
  }) : this(
          enabled: enabled,
          cupertino: true,
          pressedOpacity: pressedOpacity,
          onTap: onTap,
          child: child,
          key: key,
        );
}
