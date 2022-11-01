part of 'widgets.dart';

class SmartLinearProgress extends StatelessWidget {
  const SmartLinearProgress({
    this.visible = true,
    this.height = 1.7,
    this.color,
    this.value,
    Key? key,
  }) : super(key: key);

  const SmartLinearProgress.standard({
    this.visible = true,
    this.height = 2.4,
    this.color,
    this.value,
    Key? key,
  }) : super(key: key);

  final bool visible;
  final Color? color;
  final double height;
  final double? value;

  @override
  Widget build(BuildContext context) => SmartCrossFade(
        showFirst: visible,
        firstChild: LinearProgressIndicator(
          minHeight: height,
          backgroundColor: Colors.transparent,
          color: color,
          value: value,
        ),
        secondChild: Container(height: height),
      );

  PreferredSize get preferredSize => PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: this,
      );
}

class SmartCrossFade extends AnimatedCrossFade {
  const SmartCrossFade({
    bool? showFirst,
    AlignmentGeometry alignment = Alignment.topCenter,
    Duration duration = const Duration(milliseconds: 200),
    Widget? firstChild,
    Widget? secondChild,
    Key? key,
  }) : super(
          key: key,
          alignment: alignment,
          duration: duration,
          secondCurve: Curves.fastLinearToSlowEaseIn,
          crossFadeState: showFirst ?? firstChild != null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: firstChild ?? const SizedBox(),
          secondChild: secondChild ?? const SizedBox(),
        );
}

class SmartProgressBar extends StatelessWidget {
  const SmartProgressBar({
    super.key,
    this.value = 0.0,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.height = 12.0,
    this.width,
    this.curve = Curves.fastOutSlowIn,
    this.duration = const Duration(milliseconds: 500),
  });

  final double value;
  final double? borderRadius;
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final double? width;
  final Curve curve;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.primaryColor;
    final backgroundColor = this.backgroundColor ?? context.backgroundColor;
    final borderRadius = this.borderRadius ?? height;
    return SizedBox(
      width: width,
      child: Material(
        shape: borderRadius.roundedRectangleBorder(),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: height),
              color: backgroundColor,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth * value;
                return AnimatedContainer(
                  curve: curve,
                  duration: duration,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: borderRadius.borderRadiusCircular,
                  ),
                  height: height,
                  width: width,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
