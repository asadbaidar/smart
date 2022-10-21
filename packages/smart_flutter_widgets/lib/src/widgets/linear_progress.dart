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
