// ignore_for_file: unnecessary_null_comparison
part of 'widgets.dart';

/// Scroll physics that always lets the user scroll and bounce back
/// from the edge.
class AlwaysBouncingScrollPhysics extends BouncingScrollPhysics {
  /// Creates scroll physics that always lets the user scroll
  /// and bounce back from the edge.
  const AlwaysBouncingScrollPhysics()
      : super(parent: const AlwaysScrollableScrollPhysics());
}

typedef SmartItemBuilder<T> = Widget Function(
    BuildContext context, int index, T? data);
typedef SmartSliverBuilder = List<Widget> Function(BuildContext context);
typedef SmartSectionBuilder = Widget Function(
  BuildContext context,
  int index,
  dynamic section,
);
typedef SmartSection = dynamic Function(int index);

/// A scrollable list of widgets arranged linearly.
///
/// The [SmartListView.builder] constructor takes an [IndexedWidgetBuilder], which
/// builds the children on demand. This constructor is appropriate for list views
/// with a large (or infinite) number of children because the builder is called
/// only for those children that are actually visible.
///
/// To control the initial scroll offset of the scroll view, provide a
/// [controller] with its [ScrollController.initialScrollOffset] property set.
///
/// By default, [SmartListView] will automatically pad the list's scrollable
/// extremities to avoid partial obstructions indicated by [MediaQuery]'s
/// padding. To avoid this behavior, override with a zero [padding] property.
///
/// ### Construction
///
/// While laying out the list, visible children's elements, states and render
/// objects will be created lazily based on existing widgets
///
/// ### Destruction
///
/// When a child is scrolled out of view, the associated element subtree,
/// states and render objects are destroyed. A new child at the same position
/// in the list will be lazily recreated along with new elements, states and
/// render objects when it is scrolled back.
///
/// ### Destruction mitigation
///
/// In order to preserve state as child elements are scrolled in and out of
/// view, the following options are possible:
///
///  * Moving the ownership of non-trivial UI-state-driving business logic
///    out of the list child subtree. For instance, if a list contains posts
///    with their number of upvotes coming from a cached network response, store
///    the list of posts and upvote number in a data model outside the list. Let
///    the list child UI subtree be easily recreate-able from the
///    source-of-truth model object. Use [StatefulWidget]s in the child
///    widget subtree to store instantaneous UI state only.
///
///  * Letting [KeepAlive] be the root widget of the list child widget subtree
///    that needs to be preserved. The [KeepAlive] widget marks the child
///    subtree's top render object child for keepalive. When the associated top
///    render object is scrolled out of view, the list keeps the child's render
///    object (and by extension, its associated elements and states) in a cache
///    list instead of destroying them. When scrolled back into view, the render
///    object is repainted as-is (if it wasn't marked dirty in the interim).
///
///    This only works if `addAutomaticKeepAlives` and `addRepaintBoundaries`
///    are false since those parameters cause the [CustomListView] to wrap each child
///    widget subtree with other widgets.
///
///  * Using [AutomaticKeepAlive] widgets (inserted by default when
///    `addAutomaticKeepAlives` is true). [AutomaticKeepAlive] allows descendant
///    widgets to control whether the subtree is actually kept alive or not.
///    This behavior is in contrast with [KeepAlive], which will unconditionally keep
///    the subtree alive.
///
///    As an example, the [EditableText] widget signals its list child element
///    subtree to stay alive while its text field has input focus. If it doesn't
///    have focus and no other descendants signaled for keepalive via a
///    [KeepAliveNotification], the list child element subtree will be destroyed
///    when scrolled away.
///
///    [AutomaticKeepAlive] descendants typically signal it to be kept alive
///    by using the [AutomaticKeepAliveClientMixin], then implementing the
///    [AutomaticKeepAliveClientMixin.wantKeepAlive] getter and calling
///    [AutomaticKeepAliveClientMixin.updateKeepAlive].
///
/// The [key], [scrollDirection], [reverse], [controller], [primary], [physics],
/// and [shrinkWrap] properties on [SmartListView] map directly to the identically
/// named properties on [CustomScrollView].
///
/// The [padding] property corresponds to having a [SliverPadding] in the
/// [CustomScrollView.slivers] property instead of the list itself, and having
/// the [SliverList] instead be a child of the [SliverPadding].
class SmartListView<T> extends ScrollView {
  const SmartListView({
    required this.sliverBuilder,
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace = false,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
    bool shrinkWrap = false,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Key? key,
  })  : assert(sliverBuilder != null),
        super(
          key: key,
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

  SmartListView.builder({
    this.topSliverBuilder,
    this.bottomSliverBuilder,
    this.replacementBuilder,
    this.replace = false,
    required SmartItemBuilder<T> itemBuilder,
    List<T>? items,
    IndexedWidgetBuilder? dividerBuilder,
    WidgetBuilder? edgeDividerBuilder,
    WidgetBuilder? headerBuilder,
    WidgetBuilder? footerBuilder,
    SmartSectionBuilder? sectionBuilder,
    SmartSection? section,
    int? itemCount,
    Widget? divider,
    Widget? edgeDivider,
    EdgeInsetsGeometry? padding,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    bool removeTopPadding = true,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
    bool shrinkWrap = false,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Key? key,
  })  : assert(itemBuilder != null),
        sliverBuilder = ((_) => [
              SmartSliverList.builder(
                itemBuilder: itemBuilder,
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
              )
            ]),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          semanticChildCount: itemCount ?? items?.length,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        );

  final SmartSliverBuilder sliverBuilder;
  final SmartSliverBuilder? topSliverBuilder;
  final SmartSliverBuilder? bottomSliverBuilder;
  final WidgetBuilder? replacementBuilder;
  final bool replace;

  @override
  List<Widget> buildSlivers(BuildContext context) => [
        if (topSliverBuilder != null) ...topSliverBuilder!(context),
        ..._sliverBuilder(context),
        if (bottomSliverBuilder != null) ...bottomSliverBuilder!(context),
      ];

  bool get _replace => replace && replacementBuilder != null;

  List<Widget> _sliverBuilder(BuildContext context) => _replace
      ? [replacementBuilder!(context).sliverFill]
      : sliverBuilder(context);
}
