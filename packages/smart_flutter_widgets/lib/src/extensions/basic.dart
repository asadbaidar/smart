part of 'extensions.dart';

extension BasicWidget on Widget {
  PreferredSizeWidget prefferedSize(
    Size size, {
    Key? key,
  }) =>
      PreferredSize(
        key: key,
        preferredSize: size,
        child: this,
      );

  WidgetSpan widgetSpan({
    PlaceholderAlignment alignment = ui.PlaceholderAlignment.middle,
    TextBaseline? baseline,
    TextStyle? style,
  }) =>
      WidgetSpan(
        child: this,
        alignment: alignment,
        baseline: baseline,
        style: style,
      );

  Widget flex({
    Key? key,
    int flex = 1,
    bool enabled = true,
    bool expanded = false,
  }) =>
      enabled
          ? Flexible(
              key: key,
              flex: flex,
              fit: expanded ? FlexFit.tight : FlexFit.loose,
              child: this,
            )
          : this;

  Widget flexible({
    Key? key,
    int flex = 1,
    bool enabled = true,
  }) =>
      this.flex(
        key: key,
        flex: flex,
        enabled: enabled,
      );

  Widget expanded({
    Key? key,
    int flex = 1,
    bool enabled = true,
  }) =>
      this.flex(
        key: key,
        flex: flex,
        enabled: enabled,
        expanded: true,
      );

  Widget paddingAll(double? padding) => Padding(
        padding: EdgeInsetsDirectional.all(padding ?? 0),
        child: this,
      );

  Widget paddingOnly({
    double? start,
    double? top,
    double? end,
    double? bottom,
  }) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
          start: start ?? 0,
          top: top ?? 0,
          end: end ?? 0,
          bottom: bottom ?? 0,
        ),
        child: this,
      );

  Widget paddingSymmetric({
    double? horizontal,
    double? vertical,
  }) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
          start: horizontal ?? 0,
          end: horizontal ?? 0,
          top: vertical ?? 0,
          bottom: vertical ?? 0,
        ),
        child: this,
      );
}

extension SpaceNumber on num {
  Widget get spaceX => Space.x(toDouble());

  Widget get spaceY => Space.y(toDouble());

  Widget get space => Space.all(toDouble());
}

class SmartOffset extends Offset {
  const SmartOffset.only({double dx = 0, double dy = 0}) : super(dx, dy);

  const SmartOffset.all(double d) : super(d, d);
}

class SmartBoxBorder {
  SmartBoxBorder._();

  static BoxDecoration only({
    BuildContext? context,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Color? boxColor,
    Color? color,
    double? radius,
  }) {
    final vBorderColor = color ?? context?.hintColor.dimmed;
    return BoxDecoration(
      color: boxColor ?? context?.surfaceContainerColor,
      borderRadius: radius == null ? null : BorderRadius.circular(radius),
      border: vBorderColor == null
          ? null
          : Border(
              top: top != null
                  ? BorderSide(width: top, color: vBorderColor)
                  : BorderSide.none,
              bottom: bottom != null
                  ? BorderSide(width: bottom, color: vBorderColor)
                  : BorderSide.none,
              left: left != null
                  ? BorderSide(width: left, color: vBorderColor)
                  : BorderSide.none,
              right: right != null
                  ? BorderSide(width: right, color: vBorderColor)
                  : BorderSide.none,
            ),
    );
  }

  static BoxDecoration symmetric({
    BuildContext? context,
    double? vertical,
    double? horizontal,
    Color? boxColor,
    Color? color,
    double? radius,
  }) =>
      only(
        context: context,
        top: vertical,
        bottom: vertical,
        left: horizontal,
        right: horizontal,
        boxColor: boxColor,
        color: color,
        radius: radius,
      );

  static BoxDecoration all({
    BuildContext? context,
    double? border,
    Color? boxColor,
    Color? color,
    double? radius,
  }) =>
      symmetric(
        context: context,
        vertical: border,
        horizontal: border,
        boxColor: boxColor,
        color: color,
        radius: radius,
      );
}

extension ScrollToController on ScrollController {
  void scrollToTop() =>
      animateTo(0.0, duration: 200.milliseconds, curve: Curves.ease);

  void scrollToBottom() => animateTo(
        position.maxScrollExtent,
        duration: 200.milliseconds,
        curve: Curves.ease,
      );
}

extension EdgeInsetsSTEB on EdgeInsetsGeometry {
  EdgeInsets? get edgeInsets => $cast(this);

  EdgeInsetsDirectional? get edgeInsetsDirectional => $cast(this);

  double get start => edgeInsets?.left ?? edgeInsetsDirectional?.start ?? 0.0;

  double get top => edgeInsets?.top ?? edgeInsetsDirectional?.top ?? 0.0;

  double get end => edgeInsets?.right ?? edgeInsetsDirectional?.end ?? 0.0;

  double get bottom =>
      edgeInsets?.bottom ?? edgeInsetsDirectional?.bottom ?? 0.0;
}
