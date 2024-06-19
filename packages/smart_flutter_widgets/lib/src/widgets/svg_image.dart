part of 'widgets.dart';

/// Base SVG provider
abstract class SmartSvgProvider {
  SmartSvgProvider({
    this.assetName,
    this.bundle,
    this.package,
  });

  final String? assetName;
  final AssetBundle? bundle;
  final String? package;
}

/// Asset SVG provider
class SmartSvgAsset extends SmartSvgProvider {
  SmartSvgAsset(
    String assetName, {
    super.bundle,
    super.package,
  }) : super(
          assetName: assetName,
        );
}

/// A widget that will parse SVG data for rendering on screen.
class SmartSvgImage extends StatelessWidget {
  SmartSvgImage(
    this.svgProvider, {
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.theme = const SvgTheme(),
    Color? color,
    BlendMode? colorBlendMode,
    ColorFilter? colorFilter,
    super.key,
  }) : colorFilter = colorFilter ?? _getColorFilter(color, colorBlendMode);

  SmartSvgImage.asset(
    String assetName, {
    AssetBundle? bundle,
    String? package,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.theme = const SvgTheme(),
    Color? color,
    BlendMode? colorBlendMode,
    ColorFilter? colorFilter,
    super.key,
  })  : svgProvider = SmartSvgAsset(
          assetName,
          bundle: bundle,
          package: package,
        ),
        colorFilter = colorFilter ?? _getColorFilter(color, colorBlendMode);

  final SmartSvgProvider svgProvider;
  final bool matchTextDirection;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final SvgTheme theme;
  final ColorFilter? colorFilter;

  static ColorFilter? _getColorFilter(
    Color? color,
    BlendMode? colorBlendMode,
  ) =>
      color == null
          ? null
          : ColorFilter.mode(color, colorBlendMode ?? BlendMode.srcIn);

  @override
  Widget build(BuildContext context) => svgProvider is SmartSvgAsset
      ? SvgPicture.asset(
          svgProvider.assetName!,
          bundle: svgProvider.bundle,
          package: svgProvider.package,
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          theme: theme,
          colorFilter: colorFilter,
        )
      : Container();
}
