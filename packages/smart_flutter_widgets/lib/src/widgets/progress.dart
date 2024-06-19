part of 'widgets.dart';

/// Linear progress indicator with cross fade animation.
class SmartLinearProgress extends StatelessWidget {
  const SmartLinearProgress({
    this.visible = true,
    this.height = 1.7,
    this.color,
    this.value,
    super.key,
  });

  const SmartLinearProgress.standard({
    this.visible = true,
    this.height = 2.4,
    this.color,
    this.value,
    super.key,
  });

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

/// Cross fade animation between two widgets.
class SmartCrossFade extends StatelessWidget {
  const SmartCrossFade({
    super.key,
    this.animate = true,
    this.showFirst,
    this.alignment = Alignment.topCenter,
    this.duration = const Duration(milliseconds: 200),
    this.firstChild,
    this.secondChild,
  });

  final bool animate;
  final bool? showFirst;
  final AlignmentGeometry alignment;
  final Duration duration;
  final Widget? firstChild;
  final Widget? secondChild;

  @override
  Widget build(BuildContext context) => animate
      ? AnimatedCrossFade(
          alignment: alignment,
          duration: duration,
          secondCurve: Curves.fastLinearToSlowEaseIn,
          crossFadeState: state,
          firstChild: _firstChild,
          secondChild: _secondChild,
        )
      : _showFirst
          ? _firstChild
          : _secondChild;

  CrossFadeState get state =>
      _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;

  bool get _showFirst => showFirst ?? firstChild != null;

  Widget get _firstChild => firstChild ?? const SizedBox.shrink();

  Widget get _secondChild => secondChild ?? const SizedBox.shrink();
}

/// Decorated progress indicator.
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
    final backgroundColor =
        this.backgroundColor ?? context.surfaceContainerColor;
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
