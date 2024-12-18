// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

const kSmartPagingControlsHeight = 60.0;
const kSmartPagingControlsConstraints = BoxConstraints(minHeight: 60);

typedef SmartPagingCallback = void Function(PageInfo page);

/// A widget that displays a list of items by pagination on user scrolling
/// through a callback to load the next page.
class SmartPagingListView<T> extends StatelessWidget {
  /// Creates a sliver list with pagination.
  const SmartPagingListView.sliver({
    super.key,
    this.pageInfo,
    this.onPageChange,
    this.pageButtonBuilder,
    this.pageLoadingBuilder,
    this.pageFailureBuilder,
    this.pageLoading = false,
    this.pageFailure = false,
    this.pageReady = false,
    this.pageWithScrolling = true,
    required SmartSliverBuilder this.sliverBuilder,
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
  })  : addAutomaticKeepAlives = true,
        addRepaintBoundaries = true,
        addSemanticIndexes = true,
        removeTopPadding = true,
        divider = null,
        dividerBuilder = null,
        edgeDivider = null,
        edgeDividerBuilder = null,
        headerBuilder = null,
        footerBuilder = null,
        itemBuilder = null,
        items = null,
        itemCount = null,
        section = null,
        sectionBuilder = null,
        padding = null;

  /// Creates a simple list with pagination.
  const SmartPagingListView.builder({
    super.key,
    this.pageInfo,
    this.onPageChange,
    this.pageButtonBuilder,
    this.pageLoadingBuilder,
    this.pageFailureBuilder,
    this.pageLoading = false,
    this.pageFailure = false,
    this.pageReady = false,
    this.pageWithScrolling = true,
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace = false,
    required SmartItemBuilder<T> this.itemBuilder,
    this.items,
    this.dividerBuilder,
    this.edgeDividerBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.sectionBuilder,
    this.section,
    this.itemCount,
    this.divider,
    this.edgeDivider,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.removeTopPadding = true,
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
  }) : sliverBuilder = null;

  final PageInfo? pageInfo;
  final SmartPagingCallback? onPageChange;
  final SmartPageButtonBuilder? pageButtonBuilder;
  final WidgetBuilder? pageLoadingBuilder;
  final SmartPageFailureBuilder? pageFailureBuilder;
  final bool pageLoading;
  final bool pageFailure;
  final bool pageReady;
  final bool pageWithScrolling;
  final SmartSliverBuilder? sliverBuilder;
  final SmartSliverBuilder? topSliverBuilder;
  final SmartSliverBuilder? bottomSliverBuilder;
  final WidgetBuilder? replacementBuilder;
  final bool replace;
  final SmartItemBuilder<T>? itemBuilder;
  final List<T>? items;
  final IndexedWidgetBuilder? dividerBuilder;
  final WidgetBuilder? edgeDividerBuilder;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final SmartSectionBuilder? sectionBuilder;
  final SmartSection? section;
  final int? itemCount;
  final Widget? divider;
  final Widget? edgeDivider;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool removeTopPadding;
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

  bool setPagination(ScrollNotification notification) {
    if (canPaginate && notification is ScrollUpdateNotification) {
      final extent = notification.metrics.maxScrollExtent;
      final position = notification.metrics.pixels;
      final remaining = (extent - position).toInt();
      if (remaining <= 60 && remaining >= 0) {
        changePage();
      }
    }
    return true;
  }

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
      Container(
        constraints: kSmartPagingControlsConstraints,
        child: const SmartCupertinoRefresh(),
      );

  Widget _pageFailureBuilder(BuildContext context) =>
      pageFailureBuilder?.call(context, () => changePage(reload: true)) ??
      SmartPagingButton(
        onPressed: () => changePage(reload: true),
        text: 'Failed to load more. Tap to retry.',
      );

  List<Widget> _bottomSliverBuilder(BuildContext context) => [
        if (pageLoading)
          _pageLoadingBuilder(context)
              .paddingOnly(
                start: padding?.start,
                end: padding?.end,
              )
              .sliverBox
        else if (pageFailure)
          _pageFailureBuilder(context)
              .paddingOnly(
                start: padding?.start,
                end: padding?.end,
              )
              .sliverBox
        else if (!pageWithScrolling && canPaginate && pageHasMore)
          _pageButtonBuilder(context)
              .paddingOnly(
                start: padding?.start,
                end: padding?.end,
              )
              .sliverBox,
        ...?bottomSliverBuilder?.call(context),
      ];

  @override
  Widget build(BuildContext context) => (itemBuilder != null
              ? SmartListView<T>.builder(
                  topSliverBuilder: topSliverBuilder,
                  bottomSliverBuilder: _bottomSliverBuilder,
                  replacementBuilder: replacementBuilder,
                  replace: replace,
                  itemBuilder: itemBuilder!,
                  items: items,
                  dividerBuilder: dividerBuilder,
                  edgeDividerBuilder: edgeDividerBuilder,
                  headerBuilder: headerBuilder,
                  footerBuilder: footerBuilder,
                  sectionBuilder: sectionBuilder,
                  section: section,
                  itemCount: itemCount,
                  divider: divider,
                  edgeDivider: edgeDivider,
                  padding: padding,
                  addAutomaticKeepAlives: addAutomaticKeepAlives,
                  addRepaintBoundaries: addRepaintBoundaries,
                  addSemanticIndexes: addSemanticIndexes,
                  removeTopPadding: removeTopPadding,
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                  controller: controller,
                  primary: primary,
                  physics: physics,
                  shrinkWrap: shrinkWrap,
                  cacheExtent: cacheExtent,
                  dragStartBehavior: dragStartBehavior,
                  keyboardDismissBehavior: keyboardDismissBehavior,
                  restorationId: restorationId,
                  clipBehavior: clipBehavior,
                )
              : SmartListView<T>.sliver(
                  sliverBuilder: sliverBuilder!,
                  topSliverBuilder: topSliverBuilder,
                  bottomSliverBuilder: _bottomSliverBuilder,
                  replacementBuilder: replacementBuilder,
                  replace: replace,
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                  controller: controller,
                  primary: primary,
                  physics: physics,
                  shrinkWrap: shrinkWrap,
                  cacheExtent: cacheExtent,
                  dragStartBehavior: dragStartBehavior,
                  keyboardDismissBehavior: keyboardDismissBehavior,
                  restorationId: restorationId,
                  clipBehavior: clipBehavior,
                ))
          .applyIf(
        pageWithScrolling && pagingEnabled,
        (it) => NotificationListener<ScrollNotification>(
          onNotification: setPagination,
          child: it,
        ),
      );
}

/// A [SmartListView] that uses a [Data] to load value for [PagingList].
class SmartDataPagingListView<T> extends StatelessWidget {
  const SmartDataPagingListView.sliver({
    super.key,
    required this.data,
    this.onPageChange,
    this.pageButtonBuilder,
    this.pageLoadingBuilder,
    this.pageFailureBuilder,
    this.pageWithScrolling = true,
    required SmartSliverBuilder this.sliverBuilder,
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace,
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
  })  : addAutomaticKeepAlives = true,
        addRepaintBoundaries = true,
        addSemanticIndexes = true,
        removeTopPadding = true,
        divider = null,
        dividerBuilder = null,
        edgeDivider = null,
        edgeDividerBuilder = null,
        headerBuilder = null,
        footerBuilder = null,
        itemBuilder = null,
        section = null,
        sectionBuilder = null,
        padding = null,
        items = null;

  const SmartDataPagingListView.builder({
    super.key,
    required this.data,
    this.items,
    this.onPageChange,
    this.pageButtonBuilder,
    this.pageLoadingBuilder,
    this.pageFailureBuilder,
    this.pageWithScrolling = true,
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace,
    required SmartItemBuilder<T> this.itemBuilder,
    this.dividerBuilder,
    this.edgeDividerBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.sectionBuilder,
    this.section,
    this.divider,
    this.edgeDivider,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.removeTopPadding = true,
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
  }) : sliverBuilder = null;

  final Data<PagingList<T>> data;
  final List<T>? items;
  final SmartPagingCallback? onPageChange;
  final SmartPageButtonBuilder? pageButtonBuilder;
  final WidgetBuilder? pageLoadingBuilder;
  final SmartPageFailureBuilder? pageFailureBuilder;
  final bool pageWithScrolling;
  final SmartSliverBuilder? sliverBuilder;
  final SmartSliverBuilder? topSliverBuilder;
  final SmartSliverBuilder? bottomSliverBuilder;
  final WidgetBuilder? replacementBuilder;
  final bool? replace;
  final SmartItemBuilder<T>? itemBuilder;
  final IndexedWidgetBuilder? dividerBuilder;
  final WidgetBuilder? edgeDividerBuilder;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final SmartSectionBuilder? sectionBuilder;
  final SmartSection? section;
  final Widget? divider;
  final Widget? edgeDivider;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool removeTopPadding;
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

  Widget _pageFailureBuilder(BuildContext context, VoidCallback reload) =>
      pageFailureBuilder?.call(context, reload) ??
      SmartPagingButton(
        onPressed: reload,
        text: data.errorMessage,
      );

  @override
  Widget build(BuildContext context) => itemBuilder != null
      ? SmartPagingListView<T>.builder(
          pageInfo: data.page,
          onPageChange: onPageChange,
          pageButtonBuilder: pageButtonBuilder,
          pageLoadingBuilder: pageLoadingBuilder,
          pageFailureBuilder: _pageFailureBuilder,
          pageLoading: data.isPageLoading,
          pageFailure: data.isPageFailure,
          pageReady: data.isReady,
          pageWithScrolling: pageWithScrolling,
          topSliverBuilder: topSliverBuilder,
          bottomSliverBuilder: bottomSliverBuilder,
          replacementBuilder: replacementBuilder,
          replace: replace ?? data.isNotReady,
          itemBuilder: itemBuilder!,
          items: items ?? data.value?.items,
          dividerBuilder: dividerBuilder,
          edgeDividerBuilder: edgeDividerBuilder,
          headerBuilder: headerBuilder,
          footerBuilder: footerBuilder,
          sectionBuilder: sectionBuilder,
          section: section,
          divider: divider,
          edgeDivider: edgeDivider,
          padding: padding,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          removeTopPadding: removeTopPadding,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        )
      : SmartPagingListView<T>.sliver(
          pageInfo: data.page,
          onPageChange: onPageChange,
          pageLoadingBuilder: pageLoadingBuilder,
          pageFailureBuilder: _pageFailureBuilder,
          pageLoading: data.isPageLoading,
          pageFailure: data.isPageFailure,
          pageReady: data.isReady,
          pageWithScrolling: pageWithScrolling,
          sliverBuilder: sliverBuilder!,
          topSliverBuilder: topSliverBuilder,
          bottomSliverBuilder: bottomSliverBuilder,
          replacementBuilder: replacementBuilder,
          replace: replace ?? data.isNotReady,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        );
}

/// A button that can be used in [SmartPagingListView] to show more items.
class SmartPagingButton extends StatelessWidget {
  const SmartPagingButton({
    super.key,
    this.text,
    this.style,
    this.color,
    this.onPressed,
  }) : primary = false;

  const SmartPagingButton.primary({
    super.key,
    this.text,
    this.style,
    this.onPressed,
  })  : primary = true,
        color = null;

  final String? text;
  final TextStyle? style;
  final Color? color;
  final bool primary;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: kSmartPagingControlsConstraints,
      child: Center(
        child: Clickable.cupertino(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              text ?? 'Show more',
              style: (style ?? context.bodyLarge)?.copyWith(
                color: color ?? (primary ? context.primary : null),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
