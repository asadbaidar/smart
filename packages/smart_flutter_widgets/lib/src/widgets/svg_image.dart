part of 'widgets.dart';

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

class SmartSvgAsset extends SmartSvgProvider {
  SmartSvgAsset(
    String assetName, {
    AssetBundle? bundle,
    String? package,
  }) : super(
          assetName: assetName,
          bundle: bundle,
          package: package,
        );
}

class SmartSvgImage extends StatelessWidget {
  const SmartSvgImage(
    this.svgProvider, {
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
    Key? key,
  }) : super(key: key);

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
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
    Key? key,
  })  : svgProvider = SmartSvgAsset(
          assetName,
          bundle: bundle,
          package: package,
        ),
        super(key: key);

  final SmartSvgProvider svgProvider;
  final bool matchTextDirection;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final Color? color;
  final BlendMode colorBlendMode;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  final bool cacheColorFilter;
  final SvgTheme? theme;

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
          color: color,
          colorBlendMode: colorBlendMode,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
          cacheColorFilter: cacheColorFilter,
          theme: theme,
        )
      : Container();
}
