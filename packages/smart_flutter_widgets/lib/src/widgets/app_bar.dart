part of 'widgets.dart';

typedef SmartSimpleAppBar = PreferredSizeWidget;
typedef SmartSliverAppBar = List<Widget>;

const _kVerticalPadding = 16.0;
const _kHorizontalPadding = 16.0;

const kTabBarBottomConstant = 30.0;
const kSearchBarBottomConstant = 36.0;

class SmartAppBar {
  SmartAppBar._();

  static SmartSimpleAppBar simple({
    Widget? leading,
    Widget? bottom,
    Widget? flexibleSpace,
    List<Widget>? actions,
    SmartLinearProgress? progress,
    Widget? customTitle,
    String? title,
    TextStyle? titleStyle,
    ShapeBorder? shape,
    Color? backgroundColor,
    bool? centerTitle,
    bool interactive = true,
    bool? showLeading,
    bool? showProgress,
    double? elevation,
    double? toolbarHeight,
    double bottomHeight = 0.0,
    double bottomConstant = 48.0,
    double? leadingWidth,
    double? titleSpacing,
    double actionPadding = _kHorizontalPadding,
    double? leadingPadding,
  }) {
    final vActions = interactive ? actions : null;
    final vProgress = progress ??
        (showProgress != null
            ? SmartLinearProgress(visible: showProgress)
            : null);
    final vToolbarHeight = toolbarHeight ??
        (defaultTargetPlatform == TargetPlatform.iOS
            ? kMinInteractiveDimensionCupertino
            : kToolbarHeight);
    final vBottomHeight = (vProgress?.height ?? 0) +
        (bottom == null ? 0 : bottomHeight + bottomConstant);
    return PreferredSize(
      preferredSize: Size.fromHeight(vToolbarHeight + vBottomHeight),
      child: SmartBuilder((context) {
        final vShowLeading = showLeading ?? Navigator.canPop(context);
        var vLeadingWidth = leadingWidth ?? (leading == null ? 40.0 : null);
        final vLeading = vShowLeading
            ? Flexible(
                child: SizedBox(
                  width: vLeadingWidth,
                  child: (leading ?? const SmartBackButton()).paddingOnly(
                    start: leadingPadding ?? (context.isIOS ? 9 : 2),
                  ),
                ),
              ).row()
            : null;
        return AppBar(
          centerTitle:
              context.appBarCenterTitle(centerTitle, actions: vActions),
          titleTextStyle: titleStyle?.copyWith(
            color: context.appBarTheme.titleTextStyle?.color,
          ),
          flexibleSpace: flexibleSpace,
          shape: shape,
          elevation: elevation,
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          leading: vLeading,
          leadingWidth: vLeadingWidth,
          titleSpacing: titleSpacing ??
              (vShowLeading ? _kHorizontalPadding.half : _kHorizontalPadding),
          toolbarHeight: vToolbarHeight,
          title: customTitle ??
              (title != null ? Text(title) : Container(height: 0)),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(vBottomHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (bottom != null) bottom,
                if (vProgress != null) vProgress,
              ],
            ),
          ),
          actions: vActions
              ?.map((action) => action.paddingOnly(
                    end: actionPadding,
                  ))
              .toList(),
        );
      }),
    );
  }

  static SmartSliverAppBar sliver({
    Widget? leading,
    Widget? bottom, // CupertinoSearchTextField()
    List<Widget>? belowBottom,
    List<Widget>? belowSlivers,
    Widget? flexibleSpace,
    Widget? sliverRefresh,
    List<Widget>? actions,
    List<Widget>? largeActions,
    List<Widget>? largeTitleActions,
    SmartLinearProgress? progress,
    Widget? customTitle,
    Widget? customLargeTitle,
    String? title,
    TextStyle? titleStyle,
    TextStyle? largeTitleStyle,
    TextStyle? toolbarTextStyle,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    bool largeTitle = true,
    bool largeTitleAutoSize = true,
    CrossAxisAlignment largeBarCrossAlignment = CrossAxisAlignment.center,
    TextOverflow largeTitleOverflow = TextOverflow.clip,
    TextOverflow? largeTitleAutoOverflow = TextOverflow.ellipsis,
    int largeTitleMaxLines = 1,
    int largeTitleAutoMaxLines = 1,
    bool smallTitle = true,
    bool? centerTitle,
    bool floating = false,
    bool pinned = true,
    bool interactive = true,
    bool? showLeading,
    bool translucent = false,
    bool elevateAlways = true,
    bool travelActions = true,
    bool mergeActions = true,
    bool? showProgress,
    double? elevation,
    double? toolbarHeight,
    double bottomHeight = 0.0,
    double bottomConstant = kSearchBarBottomConstant,
    double largeTitleHeight = 47.0,
    double? leadingWidth,
    double? titleSpacing,
    double topPadding = _kVerticalPadding,
    double bottomPadding = _kVerticalPadding,
    double startPadding = _kHorizontalPadding,
    double endPadding = _kHorizontalPadding,
    double? verticalPadding,
    double? horizontalPadding,
    double actionPadding = _kHorizontalPadding,
    double? leadingPadding,
    SmartRefreshCallback? onRefresh,
  }) {
    if (!pinned) floating = true;
    final vActions = interactive
        ? mergeActions && travelActions
            ? actions ?? largeActions
            : actions
        : null;
    final vLargeActions = interactive
        ? mergeActions && travelActions
            ? largeActions ?? actions
            : largeActions
        : null;
    if (leading == null &&
        showLeading != true &&
        bottom == null &&
        belowBottom == null &&
        sliverRefresh == null &&
        (vActions == null || vActions.isEmpty) &&
        progress == null &&
        flexibleSpace == null &&
        showProgress == null &&
        customTitle == null &&
        (customLargeTitle == null || !largeTitle) &&
        (title == null || title.isEmpty)) {
      return [];
    }
    final vTopPadding = verticalPadding ?? topPadding;
    final vBottomPadding = verticalPadding ?? bottomPadding;
    final vStartPadding = horizontalPadding ?? startPadding;
    final vEndPadding = horizontalPadding ?? endPadding;

    final vProgress = progress ??
        (showProgress != null
            ? SmartLinearProgress(visible: showProgress)
            : null);
    final vProgressHeight = vProgress?.height ?? 0;

    final hasLargeTitle =
        customLargeTitle != null || (title != null && largeTitle);

    final vLargeTitleHeight =
        vProgressHeight + (hasLargeTitle ? largeTitleHeight : 0);

    const vLargeTitleTopPadding = 5.0;
    final vLargeTitleBottomPadding = vBottomPadding.half;

    final vBottomHeight = vProgressHeight +
        (bottom == null && belowBottom == null
            ? 0
            : bottomHeight +
                bottomConstant +
                vTopPadding.half.half +
                vBottomPadding -
                2);

    var refreshHeight = 0.0;

    void onRefreshStateChange(RefreshIndicatorMode state) {
      refreshHeight =
          state == RefreshIndicatorMode.refresh ? kRefreshIndicatorExtent : 0.0;
    }

    double getFloatingBottomHeight({double visibility = 1.0}) {
      return vBottomHeight +
          (floating || !smallTitle ? vLargeTitleHeight * visibility : 0.0);
    }

    TextStyle? getTitleTextStyle(BuildContext context, {bool large = false}) {
      final vThemeTitleStyle = context.titleTextStyle;
      final vTitleStyle = large
          ? largeTitleStyle ??
              vThemeTitleStyle?.copyWith(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              )
          : titleStyle ?? vThemeTitleStyle;
      return vTitleStyle?.copyWith(color: vThemeTitleStyle?.color);
    }

    Widget buildLargeTitle(BuildContext context, {double visibility = 1.0}) {
      Widget? vLargeTitle;
      if (customLargeTitle != null) {
        vLargeTitle = customLargeTitle;
      } else if (title != null && largeTitle) {
        final vStyle = getTitleTextStyle(context, large: true);
        final vMinFontSize =
            visibility < 1 ? vStyle?.fontSize?.floorToDouble() ?? 30.0 : 14.0;
        final titleWidgets = [
          if (largeTitleAutoSize)
            AutoSizeText(
              title,
              key: const Key('title-large-auto-size'),
              textAlign: TextAlign.start,
              minFontSize: vMinFontSize,
              overflow: largeTitleAutoOverflow,
              maxLines: largeTitleAutoMaxLines,
              style: vStyle,
            ).widgetSpan(),
          ...?largeTitleActions
              ?.map((e) => e.paddingOnly(start: 6).widgetSpan())
              .toList()
        ];
        vLargeTitle = RichText(
          key: const Key('title-large'),
          maxLines: largeTitleMaxLines,
          overflow: largeTitleOverflow,
          text: TextSpan(
            text: largeTitleAutoSize ? null : title,
            style: vStyle,
            children:
                context.isRTL ? titleWidgets.reversed.toList() : titleWidgets,
          ),
        );
      }
      return Container(
        constraints: BoxConstraints(
          minHeight: largeTitleHeight -
              vLargeTitleBottomPadding -
              vLargeTitleTopPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: largeBarCrossAlignment,
          children: [
            if (vLargeTitle != null) vLargeTitle.flex(expanded: true),
            if (vLargeActions?.isNotEmpty == true) const SizedBox(width: 2),
            ...?vLargeActions,
          ],
        ),
      );
    }

    return [
      SliverLayoutBuilder(builder: (context, constraints) {
        final appBarElevation = elevation ?? context.appBarElevation;
        final vShowLeading = showLeading ?? Navigator.canPop(context);
        final vToolbarHeight = toolbarHeight ?? context.toolbarHeight;
        final vOffsetHeight = floating
            ? vToolbarHeight
            : smallTitle
                ? vLargeTitleHeight
                : vProgressHeight;
        final vOffset = constraints.scrollOffset - refreshHeight;
        final vElevation =
            ((vOffset * 1.01) - vOffsetHeight).clamp(0.0, appBarElevation);
        final vBlur = ((vOffset * 1.01) - vOffsetHeight).clamp(0.0, 6.0);
        final vOpacity = ((vOffset - 15) / 15).clamp(0.0, 1.0);
        final vDy = ((vOffset * -1.01) + 30).clamp(0.0, 14.0);
        final vVisibility =
            smallTitle ? ((25 - vOffset) / 25).clamp(0.0, 1.0) : 1.0;
        final vOverlapping = vOffset >= vOffsetHeight;
        var vLeadingWidth = leadingWidth ?? (leading == null ? 40.0 : null);
        var vTitleSpacing = titleSpacing ??
            (vShowLeading ? _kHorizontalPadding.half : _kHorizontalPadding);
        final vLeading = vShowLeading
            ? Flexible(
                child: SizedBox(
                  width: vLeadingWidth,
                  child: (leading ?? const SmartBackButton()).paddingOnly(
                    start: leadingPadding ?? (context.isIOS ? 9 : 2),
                  ),
                ),
              ).row()
            : null;

        final Color? vBackgroundColor =
            (backgroundColor ?? context.appBarBackgroundColor)
                .applyIf(translucent && vBlur > 0, (it) => it?.translucent);

        final Color vForegroundColor =
            foregroundColor ?? context.appBarForegroundColor;

        final vTitle = customTitle ??
            title?.mapIt((it) => !hasLargeTitle
                ? Text(
                    it,
                    key: const Key("title-small-without-large"),
                  )
                : smallTitle
                    ? Transform.translate(
                        key: const Key("title-small-with-large"),
                        offset: SmartOffset.only(dy: vDy),
                        child: Opacity(
                          opacity: vOpacity,
                          child: Text(it),
                        ),
                      )
                    : null);

        final nActions = vActions
            ?.map((action) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: actionPadding,
                  ),
                  child: travelActions && hasLargeTitle && smallTitle
                      ? Transform.translate(
                          offset: SmartOffset.only(dy: vDy),
                          child: Opacity(
                            opacity: vOpacity,
                            child: action,
                          ),
                        )
                      : action,
                ))
            .toList();

        PreferredSize buildBottom() => PreferredSize(
              key: const Key("bottom-fixed"),
              preferredSize: Size.fromHeight(
                getFloatingBottomHeight(visibility: vVisibility),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ((floating || !smallTitle) && hasLargeTitle)
                    SizedBox(
                      height: vLargeTitleHeight * vVisibility,
                      child: Opacity(
                        opacity: vVisibility,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: vLargeTitleTopPadding,
                            start: vStartPadding,
                            end: vEndPadding,
                            bottom: vLargeTitleBottomPadding,
                          ),
                          child: buildLargeTitle(
                            context,
                            visibility: vVisibility,
                          ),
                        ),
                      ),
                    ),
                  if (bottom != null)
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: vTopPadding.half.half,
                        bottom: vBottomPadding - 2,
                        start: vStartPadding,
                        end: vEndPadding,
                      ),
                      child: bottom,
                    ),
                  if (belowBottom != null) ...belowBottom,
                  if (vProgress != null &&
                      (!(floating || !smallTitle) || vOverlapping))
                    vProgress,
                ],
              ),
            );

        final vBottom = floating || !smallTitle || vOverlapping && pinned
            ? buildBottom()
            : null;
        return SliverAppBar(
          leadingWidth: vLeadingWidth,
          titleSpacing: vTitleSpacing,
          automaticallyImplyLeading: false,
          leading: vLeading,
          centerTitle:
              context.appBarCenterTitle(centerTitle, actions: nActions),
          backgroundColor: vBackgroundColor,
          foregroundColor: vForegroundColor,
          title: vTitle,
          titleTextStyle: getTitleTextStyle(context),
          toolbarTextStyle: toolbarTextStyle ?? context.toolbarTextStyle,
          actions: nActions,
          elevation: vElevation,
          toolbarHeight: vToolbarHeight,
          shape: shape,
          flexibleSpace: flexibleSpace,
          //Blur(blur: _blur)
          floating: floating,
          pinned: pinned,
          bottom: vBottom,
        );
      }),
      sliverRefresh ??
          Builder(
            builder: (context) => SmartCupertinoSliverRefresh.primary(
              onRefresh: onRefresh,
              onRefreshStateChange: onRefreshStateChange,
              backgroundColor: backgroundColor ?? context.appBarBackgroundColor,
            ),
          ),
      SliverLayoutBuilder(builder: (context, constraints) {
        final vElevation = elevation ?? context.appBarElevation;
        final vToolbarHeight = toolbarHeight ?? context.toolbarHeight;
        final vOffsetHeight = floating
            ? vToolbarHeight
            : smallTitle
                ? vLargeTitleHeight
                : vProgressHeight;
        final vOffset = constraints.scrollOffset == 0
            ? constraints.overlap
            : constraints.scrollOffset;
        final vOpacity = ((25 - vOffset) / 25).clamp(0.0, 1.0);
        final vDy = vOffset.clamp(0.0, 20.0);
        final vOverlapping = constraints.overlap >= vOffsetHeight;
        final vHideBottom = floating ||
            !(hasLargeTitle && smallTitle ||
                !vOverlapping && bottom != null && belowBottom != null);
        return SliverToBoxAdapter(
          child: Material(
            color: backgroundColor ?? context.appBarTheme.backgroundColor,
            shadowColor: context.appBarTheme.shadowColor,
            elevation: elevateAlways ? vElevation * 0.8 : 0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                vHideBottom
                    ? Container(
                        color: Colors.transparent,
                        height: vElevation +
                            (floating || !smallTitle ? 0 : vLargeTitleHeight),
                      )
                    : Column(
                        key: const Key("bottom-animated"),
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.only(
                              start: vStartPadding,
                              end: vEndPadding,
                              bottom: vBottomPadding.half + 1,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (hasLargeTitle && smallTitle)
                                  Transform.translate(
                                    offset: SmartOffset.only(dy: -vDy),
                                    child: Opacity(
                                      opacity: vOpacity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: vLargeTitleTopPadding,
                                        ),
                                        child: buildLargeTitle(context),
                                      ),
                                    ),
                                  ),
                                if (!vOverlapping && bottom != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: vTopPadding.half,
                                      bottom: vBottomPadding.half,
                                    ),
                                    child: bottom,
                                  ),
                              ],
                            ),
                          ),
                          if (!vOverlapping && belowBottom != null)
                            ...belowBottom,
                        ],
                      ),
                if (!vOverlapping && vProgress != null) vProgress,
              ],
            ),
          ),
        );
      }),
      ...?belowSlivers,
    ];
  }

  static SmartSimpleAppBar modal({
    Widget? leading,
    Widget? bottom,
    Widget? flexibleSpace,
    List<Widget>? actions,
    SmartLinearProgress? progress,
    Widget? customTitle,
    String? title,
    TextStyle? titleStyle,
    ShapeBorder? shape,
    Color? backgroundColor,
    bool? centerTitle = true,
    bool interactive = true,
    bool? showLeading,
    bool? showProgress,
    double? elevation,
    double? toolbarHeight = kMinInteractiveDimensionCupertino,
    double bottomHeight = 17.0,
    double bottomConstant = 48.0,
    double? leadingWidth,
    double? titleSpacing,
    double actionPadding = 14.0,
    double leadingPadding = 8.0,
  }) {
    return simple(
      leading: leading ?? const SmartBackButton(icon: Icon(Icons.close)),
      bottom: bottom?.paddingAll(16.0),
      flexibleSpace: flexibleSpace,
      actions: actions,
      progress: progress,
      customTitle: customTitle,
      title: title,
      titleStyle: titleStyle,
      shape: shape,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      interactive: interactive,
      showLeading: showLeading,
      showProgress: showProgress,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      bottomHeight: bottomHeight,
      bottomConstant: bottomConstant,
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      actionPadding: actionPadding,
      leadingPadding: leadingPadding,
    );
  }

  static SmartSliverAppBar sliverModal({
    Widget? leading,
    Widget? bottom,
    List<Widget>? belowBottom,
    List<Widget>? belowSlivers,
    Widget? flexibleSpace,
    Widget? sliverRefresh,
    List<Widget>? actions,
    List<Widget>? largeActions,
    List<Widget>? largeTitleActions,
    SmartLinearProgress? progress,
    Widget? customTitle,
    Widget? customLargeTitle,
    String? title,
    TextStyle? titleStyle,
    TextStyle? largeTitleStyle,
    ShapeBorder? shape,
    Color? backgroundColor,
    bool? largeTitle,
    bool largeTitleAutoSize = false,
    CrossAxisAlignment largeBarCrossAlignment = CrossAxisAlignment.center,
    TextOverflow largeTitleOverflow = TextOverflow.ellipsis,
    TextOverflow? largeTitleAutoOverflow = TextOverflow.ellipsis,
    int largeTitleMaxLines = 1,
    int largeTitleAutoMaxLines = 1,
    bool smallTitle = false,
    bool centerTitle = true,
    bool floating = false,
    bool pinned = true,
    bool interactive = true,
    bool? showLeading = true,
    bool translucent = false,
    bool elevateAlways = true,
    bool travelActions = true,
    bool mergeActions = false,
    bool? showProgress,
    double? elevation,
    double? toolbarHeight = kMinInteractiveDimensionCupertino,
    double bottomHeight = 0.0,
    double bottomConstant = kSearchBarBottomConstant,
    double largeTitleHeight = 60.0,
    double? leadingWidth,
    double? titleSpacing,
    double topPadding = _kVerticalPadding,
    double bottomPadding = _kVerticalPadding,
    double startPadding = _kHorizontalPadding,
    double endPadding = _kHorizontalPadding,
    double? verticalPadding,
    double? horizontalPadding,
    double actionPadding = 14.0,
    double leadingPadding = 8.0,
    SmartRefreshCallback? onRefresh,
  }) {
    return sliver(
      leading: leading ?? const SmartBackButton(icon: Icon(Icons.close)),
      bottom: bottom,
      belowBottom: belowBottom,
      belowSlivers: belowSlivers,
      flexibleSpace: flexibleSpace,
      sliverRefresh: sliverRefresh,
      actions: actions,
      largeActions: largeActions,
      largeTitleActions: largeTitleActions,
      progress: progress,
      customTitle: customTitle ?? title?.mapIt((it) => Text(it)),
      customLargeTitle: customLargeTitle,
      title: title,
      titleStyle: titleStyle,
      largeTitleStyle: largeTitleStyle,
      shape: shape,
      backgroundColor: backgroundColor,
      largeTitle: largeTitle ?? customLargeTitle != null,
      largeTitleAutoSize: largeTitleAutoSize,
      largeBarCrossAlignment: largeBarCrossAlignment,
      largeTitleOverflow: largeTitleOverflow,
      largeTitleAutoOverflow: largeTitleAutoOverflow,
      largeTitleMaxLines: largeTitleMaxLines,
      largeTitleAutoMaxLines: largeTitleAutoMaxLines,
      smallTitle: smallTitle,
      centerTitle: centerTitle,
      floating: floating,
      pinned: pinned,
      interactive: interactive,
      showLeading: showLeading,
      translucent: translucent,
      elevateAlways: elevateAlways,
      travelActions: travelActions,
      mergeActions: mergeActions,
      showProgress: showProgress,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      bottomHeight: bottomHeight,
      bottomConstant: bottomConstant,
      largeTitleHeight: largeTitleHeight,
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      topPadding: topPadding,
      bottomPadding: bottomPadding,
      startPadding: startPadding,
      endPadding: endPadding,
      verticalPadding: verticalPadding,
      horizontalPadding: horizontalPadding,
      actionPadding: actionPadding,
      leadingPadding: leadingPadding,
      onRefresh: onRefresh,
    );
  }
}

class SmartBackButton extends StatelessWidget {
  const SmartBackButton({
    this.text,
    this.textStyle,
    this.icon,
    this.iconSize,
    this.color,
    this.padding = EdgeInsets.zero,
    this.onPressed,
    super.key,
  });

  final String? text;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? iconSize;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SmartBuilder((context) {
      final vColor = color ?? context.appBarTheme.foregroundColor;
      return CupertinoButton(
        key: const Key("back-button"),
        onPressed: onPressed ?? () => Navigator.maybePop(context),
        padding: padding,
        minSize: 0,
        child: Row(children: [
          IconTheme(
            data: IconThemeData(
              size: iconSize,
              color: vColor,
            ),
            child: icon ??
                Icon(context.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          ),
          if (text != null)
            Flexible(
              child: Text(
                text!,
                style: textStyle?.copyWith(color: vColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
        ]),
      );
    });
  }
}
