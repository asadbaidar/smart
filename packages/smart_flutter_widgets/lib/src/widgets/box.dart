part of 'widgets.dart';

class SmartBox extends StatelessWidget {
  static const double kBoxSize = 30;

  const SmartBox({
    required this.child,
    this.color,
    this.filled = true,
    this.tinted = false,
    this.oval = false,
    this.small,
    this.wrap = false,
    this.custom = false,
    this.safeBorder = false,
    this.boxSize = kBoxSize,
    this.fontSize,
    this.iconSize,
    this.margin = const EdgeInsets.symmetric(horizontal: 5),
    this.onTap,
    Key? key,
  }) : super(key: key);

  const SmartBox.custom({
    required this.child,
    this.color,
    this.filled = false,
    this.tinted = false,
    this.oval = false,
    this.small,
    this.wrap = false,
    this.custom = true,
    this.safeBorder = false,
    this.boxSize = kBoxSize,
    this.fontSize,
    this.iconSize,
    this.margin,
    this.onTap,
    Key? key,
  }) : super(key: key);

  const SmartBox.zero({
    required this.child,
    this.color,
    this.filled = true,
    this.tinted = false,
    this.oval = false,
    this.small,
    this.wrap = false,
    this.custom = false,
    this.safeBorder = false,
    this.boxSize = kBoxSize,
    this.fontSize,
    this.iconSize,
    this.margin,
    this.onTap,
    Key? key,
  }) : super(key: key);

  const SmartBox.wrap({
    required this.child,
    this.color,
    this.filled = false,
    this.tinted = false,
    this.oval = false,
    this.small = true,
    this.wrap = true,
    this.custom = false,
    this.safeBorder = false,
    this.boxSize = kBoxSize,
    this.fontSize,
    this.iconSize,
    this.margin,
    this.onTap,
    Key? key,
  }) : super(key: key);

  const SmartBox.oval({
    required this.child,
    this.color,
    this.filled = true,
    this.tinted = false,
    this.oval = true,
    this.small,
    this.wrap = false,
    this.custom = false,
    this.safeBorder = false,
    this.boxSize = kBoxSize,
    this.fontSize,
    this.iconSize,
    this.margin,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final dynamic child;
  final Color? color;
  final bool filled;
  final bool tinted;
  final bool oval;
  final bool? small;
  final bool wrap;
  final bool custom;
  final bool safeBorder;
  final double boxSize;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final splash =
        (filled ? color?.darker : color?.lighted) ?? Colors.black.lighted;
    return Container(
      margin: margin,
      width: _boxSize,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: oval
              ? _size?.borderRadiusCircular
              : _size?.sizeToCupertinoRadius.borderRadiusCircular,
          highlightColor: splash.highlighted,
          splashColor: splash,
          child: Ink(
            height: _wrapSize,
            width: _wrapSize,
            decoration: oval
                ? _size?.radiusToBoxDecoration(color: color, border: safeBorder)
                : _size?.sizeToCupertinoRadius
                    .radiusToBoxDecoration(color: color, border: safeBorder),
            child: Container(
              alignment: Alignment.center,
              child: _text() ??
                  _icon() ??
                  (_image() ?? _svg() ?? _child())?.clipOval(clip: oval),
            ),
          ),
        ),
      ),
    );
  }

  double? get _boxSize => wrap ? null : boxSize;

  double? get _wrapSize => filled ? _boxSize : null;

  double? get _size => filled ? boxSize : null;

  Widget? _text() => $cast<Text>(child is! Widget &&
                  child is! ImageProvider &&
                  child is! SmartSvgProvider &&
                  child is! IconData &&
                  child?.toString().isNotEmpty == true
              ? Text(child.toString())
              : child)
          ?.mapTo(
        (Text it) => Text(
          it.data?.take(boxSize > kBoxSize ? 3 : 2).uppercase ?? "",
          textAlign: TextAlign.center,
          style: GoogleFonts.voltaire(
            fontSize: fontSize ??
                (filled
                    ? ((oval ? 15 : 17) - max(0, (kBoxSize - boxSize).half))
                    : small == true
                        ? 18
                        : 24),
            color: tinted
                ? filled
                    ? color?.contrast
                    : color
                : null,
            // fontWeight: FontWeight.w100,
          ),
        ),
      );

  Widget? _icon() => $cast<Icon>(
          $cast<IconData>(child)?.mapTo((IconData it) => Icon(it)) ?? child)
      ?.mapTo((Icon it) => IconTheme(
            data: IconThemeData(
              size: it.size ??
                  iconSize ??
                  (filled
                      ? 18
                      : small == true
                          ? 24
                          : 30),
              color: tinted
                  ? it.color ?? (filled ? color?.contrast : color)
                  : null,
            ),
            child: it,
          ));

  double get _iconSize =>
      iconSize ??
      (filled && tinted
          ? 18
          : small == true
              ? 24
              : boxSize);

  Widget? _image() => $cast<ImageProvider>(child)?.mapIt((it) => Image(
        image: it,
        height: _iconSize,
        width: _iconSize,
        color: tinted
            ? filled
                ? color?.contrast
                : color
            : null,
        fit: BoxFit.cover,
      ));

  Widget? _svg() => $cast<SmartSvgAsset>(child)?.mapIt((it) => SmartSvgImage(
        it,
        height: _iconSize,
        width: _iconSize,
        color: tinted
            ? filled
                ? color?.contrast
                : color
            : null,
        fit: BoxFit.cover,
      ));

  Widget? _child() => $cast<Widget>(child);
}
