part of 'widgets.dart';

/// A widget that shows a dot on top of another widget. It can be used to show
/// notifications.
class SmartNotificationDot extends StatelessWidget {
  const SmartNotificationDot({
    super.key,
    required this.child,
    required this.showDot,
    this.color,
    this.borderColor,
    this.size = 8,
    this.borderSize = 2,
    this.alignment = Alignment.topRight,
  });

  final Widget child;
  final bool showDot;
  final Color? color;
  final Color? borderColor;
  final double size;
  final double borderSize;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: alignment,
        children: [
          child,
          if (showDot)
            Container(
              alignment: Alignment.center,
              height: (borderSize * 2) + size,
              width: (borderSize * 2) + size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: borderColor,
              ),
              child: Container(
                alignment: Alignment.center,
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color ?? context.colorScheme.error,
                ),
              ),
            ),
        ],
      );
}
