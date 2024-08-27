import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

/// An animated button that mimics the behavior of expanding and collapsing
/// with easy to customize animations.
class SmartDetailButton extends StatelessWidget {
  const SmartDetailButton({
    this.icon,
    this.color,
    this.tooltip,
    this.size,
    this.transform,
    this.rotate180,
    this.rotate90,
    this.onPressed,
    super.key,
  });

  final Widget? icon;
  final Color? color;
  final String? tooltip;
  final double? size;
  final Matrix4? transform;
  final bool? rotate180;
  final bool? rotate90;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: 200.milliseconds,
        transformAlignment: Alignment.center,
        transform: transform ??
            $mapTo(
              rotate180,
              (it) => Matrix4.rotationZ(it ? pi : 0)
                ..rotateY(context.isRTL ? pi : 0),
            ) ??
            $mapTo(
              rotate90,
              (it) =>
                  Matrix4.rotationZ(it ? (context.isRTL ? -1 : 1) * pi / 2 : 0),
            ),
        child: IconTheme(
          data: IconThemeData(
            color: color,
            size: size,
          ),
          child: icon ?? const Icon(CupertinoIcons.chevron_right),
        ),
      ),
    );
  }
}
