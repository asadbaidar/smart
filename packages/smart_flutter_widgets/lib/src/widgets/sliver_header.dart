part of 'widgets.dart';

/// {@template smart_sliver_header}
/// Builder for the widget to place inside the [SmartSliverHeader].
///
/// The `context` is the [BuildContext] of the sliver.
///
/// The `shrinkOffset` is a distance from [maxExtent] towards [minExtent]
/// representing the current amount by which the sliver has been shrunk. When
/// the `shrinkOffset` is zero, the contents will be rendered with a dimension
/// of [maxExtent] in the main axis. When `shrinkOffset` equals the difference
/// between [maxExtent] and [minExtent] (a positive number), the contents will
/// be rendered with a dimension of [minExtent] in the main axis. The
/// `shrinkOffset` will always be a positive number in that range.
///
/// The `overlapsContent` argument is true if subsequent slivers (if any) will
/// be rendered beneath this one, and false if the sliver will not have any
/// contents below it. Typically this is used to decide whether to draw a
/// shadow to simulate the sliver being above the contents below it. Typically
/// this is true when `shrinkOffset` is at its greatest value and false
/// otherwise, but that is not guaranteed. See [NestedScrollView] for an
/// example of a case where `overlapsContent`'s value can be unrelated to
/// `shrinkOffset`.
/// {@endtemplate}
typedef SmartSliverHeaderBuilder = Widget Function(
  BuildContext context,
  double shrinkOffset,
  bool overlapsContent,
);

/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
///
/// In the normal case of a [CustomScrollView] with no centered sliver, this
/// sliver will vary its size when scrolled to the leading edge of the viewport.
///
/// This is the layout primitive that [SliverAppBar] uses for its
/// shrinking/growing effect.
class SmartSliverHeader extends StatefulWidget {
  /// {@template header_constructor}
  /// Creates a sliver that varies its size when it is scrolled to the start of
  /// a viewport.
  /// {@endtemplate}
  const SmartSliverHeader({
    required this.builder,
    this.minExtent = 0.0,
    this.maxExtent = 0.0,
    this.pinned = false,
    this.floating = false,
    this.snapConfiguration,
    this.stretchConfiguration,
    this.showOnScreenConfiguration,
    super.key,
  });

  /// {@macro header_constructor}
  /// Defaults to pinned.
  const SmartSliverHeader.pinned({
    required this.builder,
    this.minExtent = 0.0,
    this.maxExtent = 0.0,
    this.floating = false,
    this.snapConfiguration,
    this.stretchConfiguration,
    this.showOnScreenConfiguration,
    super.key,
  }) : pinned = true;

  /// {@macro smart_sliver_header}
  final SmartSliverHeaderBuilder builder;

  /// Whether to stick the header to the start of the viewport once it has
  /// reached its minimum size.
  ///
  /// If this is false, the header will continue scrolling off the screen after
  /// it has shrunk to its minimum extent.
  final bool pinned;

  /// Whether the header should immediately grow again if the user reverses
  /// scroll direction.
  ///
  /// If this is false, the header only grows again once the user reaches the
  /// part of the viewport that contains the sliver.
  ///
  /// The [delegate]'s [SmartSliverHeaderDelegate.snapConfiguration] is
  /// ignored unless [floating] is true.
  final bool floating;

  /// The smallest size to allow the header to reach, when it shrinks at the
  /// start of the viewport.
  ///
  /// This must return a value equal to or less than [maxExtent].
  ///
  /// This value should not change over the lifetime of the delegate. It should
  /// be based entirely on the constructor arguments passed to the delegate. See
  /// [shouldRebuild], which must return true if a new delegate would return a
  /// different value.
  final double minExtent;

  /// The size of the header when it is not shrinking at the top of the
  /// viewport.
  ///
  /// This must return a value equal to or greater than [minExtent].
  ///
  /// This value should not change over the lifetime of the delegate. It should
  /// be based entirely on the constructor arguments passed to the delegate. See
  /// [shouldRebuild], which must return true if a new delegate would return a
  /// different value.
  final double maxExtent;

  /// Specifies how floating headers should animate in and out of view.
  ///
  /// If the value of this property is null, then floating headers will
  /// not animate into place.
  ///
  /// This is only used for floating headers (those with
  /// [SliverPersistentHeader.floating] set to true).
  ///
  /// Defaults to null.
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  /// Specifies an [AsyncCallback] and offset for execution.
  ///
  /// If the value of this property is null, then callback will not be
  /// triggered.
  ///
  /// This is only used for stretching headers (those with
  /// [SliverAppBar.stretch] set to true).
  ///
  /// Defaults to null.
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  /// Specifies how floating headers and pinned headers should behave in
  /// response to [RenderObject.showOnScreen] calls.
  ///
  /// Defaults to null.
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  State<SmartSliverHeader> createState() => _SmartSliverHeaderState();
}

class _SmartSliverHeaderState extends State<SmartSliverHeader>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: widget.pinned,
      floating: widget.floating,
      delegate: SmartSliverHeaderDelegate(
        vsync: this,
        builder: widget.builder,
        minExtent: widget.minExtent,
        maxExtent: widget.maxExtent,
        snapConfiguration: widget.snapConfiguration,
        stretchConfiguration: widget.stretchConfiguration,
        showOnScreenConfiguration: widget.showOnScreenConfiguration,
      ),
    );
  }
}

/// Helper Delegate for configuring a [SliverPersistentHeader].
class SmartSliverHeaderDelegate implements SliverPersistentHeaderDelegate {
  const SmartSliverHeaderDelegate({
    required this.builder,
    this.vsync,
    this.snapConfiguration,
    this.stretchConfiguration,
    this.showOnScreenConfiguration,
    this.minExtent = 0,
    double maxExtent = 0,
  }) : maxExtent = maxExtent < minExtent ? minExtent : maxExtent;

  /// {@macro smart_sliver_header}
  final SmartSliverHeaderBuilder builder;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  final TickerProvider? vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(SmartSliverHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.vsync != vsync ||
        oldDelegate.snapConfiguration != snapConfiguration ||
        oldDelegate.stretchConfiguration != stretchConfiguration ||
        oldDelegate.showOnScreenConfiguration != showOnScreenConfiguration;
  }
}
