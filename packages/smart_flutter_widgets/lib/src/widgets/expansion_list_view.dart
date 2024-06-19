part of 'widgets.dart';

typedef SmartExpansionPanelBuilder<PanelItem, ListItem>
    = SmartExpansionPanel<ListItem> Function(
  BuildContext,
  int index,
  PanelItem? data,
);

/// A list view that allows for expansion of a single or multiple panels.
class SmartExpansionListView<PanelItem, ListItem> extends StatefulWidget {
  const SmartExpansionListView({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.items,
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace = false,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics = const AlwaysBouncingScrollPhysics(),
    this.shrinkWrap = false,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.allowMultipleExpansion = false,
    this.padding,
  });

  final SmartExpansionPanelBuilder<PanelItem, ListItem> itemBuilder;
  final int? itemCount;
  final List<PanelItem>? items;
  final SmartSliverBuilder? topSliverBuilder;
  final SmartSliverBuilder? bottomSliverBuilder;
  final WidgetBuilder? replacementBuilder;
  final bool replace;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final bool allowMultipleExpansion;
  final EdgeInsetsGeometry? padding;

  int get _itemCount => items?.length ?? itemCount ?? 0;

  double get _topPadding => padding?.top ?? 0;
  double get _bottomPadding => padding?.bottom ?? 0;
  double get _startPadding => padding?.start ?? 0;
  double get _endPadding => padding?.end ?? 0;

  @override
  State<SmartExpansionListView<PanelItem, ListItem>> createState() =>
      _SmartExpansionListViewState<PanelItem, ListItem>();
}

class _SmartExpansionListViewState<PanelItem, ListItem>
    extends State<SmartExpansionListView<PanelItem, ListItem>> {
  late List<bool> _expansionStates;
  int _lastExpanedIndex = -1;

  void _setExpansion() {
    _expansionStates = List.filled(widget._itemCount, false);
  }

  @override
  void initState() {
    super.initState();
    _setExpansion();
  }

  @override
  void didUpdateWidget(SmartExpansionListView<PanelItem, ListItem> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items ||
        oldWidget.itemCount != widget.itemCount) {
      _setExpansion();
    }
  }

  void toggleExpanded(int index, [SmartExpansionPanel<ListItem>? panel]) {
    if (!widget.allowMultipleExpansion &&
        _lastExpanedIndex >= 0 &&
        _lastExpanedIndex != index) {
      _expansionStates[_lastExpanedIndex] = false;
    }
    _toggleExpanded(index, panel);
  }

  void _toggleExpanded(int index, [SmartExpansionPanel<ListItem>? panel]) {
    final isExpanded = _expansionStates[index] = !_expansionStates[index];
    panel?.onChangeExpansion?.call(isExpanded);
    if (isExpanded) {
      _lastExpanedIndex = index;
      panel?.onExpand?.call();
    } else {
      panel?.onCollapse?.call();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SmartListView<dynamic>.sliver(
      topSliverBuilder: widget.topSliverBuilder,
      bottomSliverBuilder: widget.bottomSliverBuilder,
      replacementBuilder: widget.replacementBuilder,
      replace: widget.replace,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      cacheExtent: widget.cacheExtent,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      sliverBuilder: (context) => [
        widget._topPadding.spaceY.sliverBox,
        for (int index = 0; index < widget._itemCount; index++)
          ...?$mapTo(
            widget.itemBuilder(
              context,
              index,
              widget.items?[index],
            ),
            (panel) => panel._buildSLivers(
              context,
              toggleExpanded: () => toggleExpanded(index, panel),
              isExpanded: _expansionStates[index],
              startPadding: widget._startPadding,
              endPadding: widget._endPadding,
            ),
          ),
        widget._bottomPadding.spaceY.sliverBox,
      ],
    );
  }
}

typedef SmartExpansionWidgetBuilder = Widget Function(
  BuildContext context,
  VoidCallback toggle,
  bool isExpanded,
);

typedef SmartExpansionCallback = void Function(bool isExpanded);

typedef SmartPageFailureBuilder = Widget Function(
  BuildContext context,
  VoidCallback reload,
);
typedef SmartPageButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback load,
);

/// An expansion panel that can be either expanded or collapsed.
class SmartExpansionPanel<T> {
  const SmartExpansionPanel({
    required this.expansionBuilder,
    required this.itemBuilder,
    this.items,
    this.dividerBuilder,
    this.edgeDividerBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.replacementBuilder,
    this.replace = false,
    this.sectionBuilder,
    this.section,
    this.itemCount,
    this.divider,
    this.edgeDivider,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.removeTopPadding = true,
    this.scrollDirection = Axis.vertical,
    this.pageInfo,
    this.onPageChange,
    this.pageButtonBuilder,
    this.pageLoadingBuilder,
    this.pageFailureBuilder,
    this.pageLoading = false,
    this.pageFailure = false,
    this.pageReady = false,
    this.onChangeExpansion,
    this.onExpand,
    this.onCollapse,
  });

  final SmartExpansionWidgetBuilder expansionBuilder;
  final SmartItemBuilder<T> itemBuilder;
  final List<T>? items;
  final IndexedWidgetBuilder? dividerBuilder;
  final WidgetBuilder? edgeDividerBuilder;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final WidgetBuilder? replacementBuilder;
  final bool replace;
  final SmartSectionBuilder? sectionBuilder;
  final SmartSection? section;
  final int? itemCount;
  final Widget? divider;
  final Widget? edgeDivider;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool removeTopPadding;
  final Axis scrollDirection;
  final PageInfo? pageInfo;
  final SmartPagingCallback? onPageChange;
  final SmartPageButtonBuilder? pageButtonBuilder;
  final WidgetBuilder? pageLoadingBuilder;
  final SmartPageFailureBuilder? pageFailureBuilder;
  final bool pageLoading;
  final bool pageFailure;
  final bool pageReady;
  final SmartExpansionCallback? onChangeExpansion;
  final VoidCallback? onExpand;
  final VoidCallback? onCollapse;

  bool get _replace => replace && replacementBuilder != null;

  bool get pagingEnabled => pageInfo != null && onPageChange != null;

  bool get pageHasMore => pageInfo?.hasMore ?? false;

  bool get canPaginate => !pageLoading && pageReady && pagingEnabled;

  void changePage({bool reload = false}) {
    final hasMore = reload || pageHasMore;
    if (canPaginate && hasMore) {
      onPageChange!(
        pageInfo!.copyWith(
          current: pageInfo!.current + (reload ? 0 : 1),
        ),
      );
    }
  }

  Widget _pageButtonBuilder(BuildContext context) =>
      pageButtonBuilder?.call(context, changePage) ??
      SmartPagingButton.primary(onPressed: changePage);

  Widget _pageLoadingBuilder(BuildContext context) =>
      pageLoadingBuilder?.call(context) ??
      const SizedBox(
        height: kSmartPagingControlsHeight,
        child: SmartCupertinoRefresh(),
      );

  Widget _pageFailureBuilder(BuildContext context) =>
      pageFailureBuilder?.call(context, () => changePage(reload: true)) ??
      SmartPagingButton(
        onPressed: () => changePage(reload: true),
        text: 'Failed to load more. Tap to retry.',
      );

  Widget _pageBuilder(BuildContext context) {
    if (pageLoading) {
      return _pageLoadingBuilder(context);
    } else if (pageFailure) {
      return _pageFailureBuilder(context);
    } else if (canPaginate && pageHasMore) {
      return _pageButtonBuilder(context);
    } else {
      return const SizedBox();
    }
  }

  List<Widget> _buildSLivers(
    BuildContext context, {
    required VoidCallback toggleExpanded,
    required bool isExpanded,
    required double startPadding,
    required double endPadding,
  }) {
    return [
      expansionBuilder(context, toggleExpanded, isExpanded)
          .paddingOnly(
            start: startPadding,
            end: endPadding,
          )
          .sliverBox,
      SliverAnimatedOpacity(
        opacity: isExpanded ? 1 : 0,
        duration: 200.milliseconds,
        sliver: !isExpanded
            ? const SliverToBoxAdapter()
            : _replace
                ? replacementBuilder!(context).sliverBox
                : SmartSliverList<T>.builder(
                    padding: EdgeInsetsDirectional.only(
                      start: startPadding,
                      end: endPadding,
                    ),
                    itemBuilder: itemBuilder,
                    dividerBuilder: dividerBuilder,
                    edgeDividerBuilder: edgeDividerBuilder,
                    headerBuilder: headerBuilder,
                    footerBuilder: footerBuilder,
                    sectionBuilder: sectionBuilder,
                    items: items,
                    section: section,
                    itemCount: itemCount,
                    divider: divider,
                    edgeDivider: edgeDivider,
                    addAutomaticKeepAlives: addAutomaticKeepAlives,
                    addRepaintBoundaries: addRepaintBoundaries,
                    addSemanticIndexes: addSemanticIndexes,
                    removeTopPadding: removeTopPadding,
                    scrollDirection: scrollDirection,
                  ),
      ),
      if (isExpanded && pagingEnabled)
        _pageBuilder(context)
            .paddingOnly(
              start: startPadding,
              end: endPadding,
            )
            .sliverBox,
    ];
  }
}

/// A [SmartExpansionPanel] that uses an [DataState] for [PagingList] to build
///  its content.
class SmartExpansionPagingApiStatePanel<T> extends SmartExpansionPanel<T> {
  SmartExpansionPagingApiStatePanel({
    required DataState<PagingList<T>> dataState,
    required super.expansionBuilder,
    required super.itemBuilder,
    super.dividerBuilder,
    super.edgeDividerBuilder,
    super.headerBuilder,
    super.footerBuilder,
    super.replacementBuilder,
    bool? replace,
    super.sectionBuilder,
    super.section,
    super.divider,
    super.edgeDivider,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.scrollDirection = Axis.vertical,
    super.onPageChange,
    super.pageButtonBuilder,
    super.pageLoadingBuilder,
    SmartPageFailureBuilder? pageFailureBuilder,
    super.onChangeExpansion,
    super.onExpand,
    super.onCollapse,
  }) : super(
          items: dataState.data?.items,
          replace: replace ?? dataState.isNotReady,
          pageInfo: dataState.page,
          pageLoading: dataState.isPageLoading,
          pageFailure: dataState.isPageFailure,
          pageReady: dataState.isReady,
          pageFailureBuilder: (context, reload) {
            return pageFailureBuilder?.call(context, reload) ??
                SmartPagingButton(
                  onPressed: reload,
                  text: dataState.errorMessage,
                );
          },
        );
}
