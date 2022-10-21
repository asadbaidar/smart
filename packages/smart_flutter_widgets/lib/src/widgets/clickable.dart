part of 'widgets.dart';

class Clickable extends MouseRegion {
  Clickable({
    bool enabled = true,
    bool cupertino = false,
    double pressedOpacity = 0.4,
    VoidCallback? onTap,
    Widget? child,
    Key? key,
  }) : super(
          key: key,
          cursor: enabled && onTap != null
              ? MaterialStateMouseCursor.clickable
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
