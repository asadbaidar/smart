import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottom_sheet;
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

const kSmartBottomSheetInitialSize = 0.5;
const kSmartBottomSheetMaxSize = 0.93;
const kSmartBottomSheetMinSize = 0.4;

const ShapeBorder kSmartBottomSheetRoundedshape = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(12),
  ),
);

typedef SmartCupertinoScafold = bottom_sheet.CupertinoScaffold;
typedef SmartBarBottomSheet = bottom_sheet.BarBottomSheet;
typedef SmartModalSheetRoute<T> = bottom_sheet.ModalSheetRoute<T>;
typedef SmartCupertinoModalSheetRoute<T>
    = bottom_sheet.CupertinoModalBottomSheetRoute<T>;

/// A bottom sheet that can be expanded, collapsed, and snapped
/// to a specific size.
///
/// It supports both scrollable and non-scrollable content with builders.
class SmartBottomSheet<T> extends StatelessWidget {
  /// Creates a bottom sheet with a custom child widget.
  const SmartBottomSheet({
    super.key,
    required Widget this.child,
    this.barHandle,
    this.showBarHandle = false,
    this.removeTopPadding = true,
    this.bottom,
    this.initialSize = kSmartBottomSheetInitialSize,
    this.maxSize = kSmartBottomSheetMaxSize,
    this.minSize = kSmartBottomSheetMinSize,
    this.isScrollControlled = false,
    this.expand = false,
    this.snap = false,
    this.shape = kSmartBottomSheetRoundedshape,
    this.backgroundColor,
  }) : builder = null;

  /// Creates a bottom sheet with a scrollable child widget.
  const SmartBottomSheet.scrollable({
    super.key,
    required ScrollableWidgetBuilder this.builder,
    this.barHandle,
    this.showBarHandle = false,
    this.removeTopPadding = true,
    this.bottom,
    this.initialSize = kSmartBottomSheetInitialSize,
    this.maxSize = kSmartBottomSheetMaxSize,
    this.minSize = kSmartBottomSheetMinSize,
    this.isScrollControlled = false,
    this.expand = false,
    this.snap = false,
    this.shape = kSmartBottomSheetRoundedshape,
    this.backgroundColor,
  }) : child = null;

  /// Creates a bottom sheet with a list of items.
  SmartBottomSheet.list({
    super.key,
    SmartSliverBuilder? topSliverBuilder,
    SmartSliverBuilder? bottomSliverBuilder,
    WidgetBuilder? replacementBuilder,
    bool replace = false,
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
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
    bool shrinkWrap = false,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    this.barHandle,
    this.showBarHandle = false,
    this.removeTopPadding = true,
    this.bottom,
    this.initialSize = kSmartBottomSheetInitialSize,
    this.maxSize = kSmartBottomSheetMaxSize,
    this.minSize = kSmartBottomSheetMinSize,
    this.isScrollControlled = false,
    this.expand = false,
    this.snap = false,
    this.shape = kSmartBottomSheetRoundedshape,
    this.backgroundColor,
  })  : child = null,
        builder = ((context, scrollController) => SmartListView<T>.builder(
              topSliverBuilder: topSliverBuilder,
              bottomSliverBuilder: bottomSliverBuilder,
              replacementBuilder: replacementBuilder,
              replace: replace,
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
              scrollDirection: scrollDirection,
              reverse: reverse,
              controller: scrollController,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
            ));

  /// Creates a bottom sheet with a sliver list of items.
  SmartBottomSheet.sliver({
    super.key,
    SmartSliverBuilder? topSliverBuilder,
    SmartSliverBuilder? bottomSliverBuilder,
    WidgetBuilder? replacementBuilder,
    bool replace = false,
    required SmartSliverBuilder sliverBuilder,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
    bool shrinkWrap = false,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    this.barHandle,
    this.showBarHandle = false,
    this.removeTopPadding = true,
    this.bottom,
    this.initialSize = kSmartBottomSheetInitialSize,
    this.maxSize = kSmartBottomSheetMaxSize,
    this.minSize = kSmartBottomSheetMinSize,
    this.isScrollControlled = false,
    this.expand = false,
    this.snap = false,
    this.shape = kSmartBottomSheetRoundedshape,
    this.backgroundColor,
  })  : child = null,
        builder = ((context, scrollController) => SmartListView<T>.sliver(
              topSliverBuilder: topSliverBuilder,
              bottomSliverBuilder: bottomSliverBuilder,
              replacementBuilder: replacementBuilder,
              replace: replace,
              sliverBuilder: sliverBuilder,
              scrollDirection: scrollDirection,
              reverse: reverse,
              controller: scrollController,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
            ));

  final Widget? child;
  final ScrollableWidgetBuilder? builder;
  final Widget? barHandle;
  final bool showBarHandle;
  final bool removeTopPadding;
  final Widget? bottom;
  final double initialSize;
  final double maxSize;
  final double minSize;
  final bool isScrollControlled;
  final bool expand;
  final bool snap;
  final ShapeBorder? shape;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => isScrollControlled
      ? DraggableScrollableSheet(
          maxChildSize: maxSize,
          expand: expand,
          snap: snap,
          initialChildSize: initialSize,
          minChildSize: minSize,
          snapSizes: snap ? [initialSize] : null,
          builder: _buildBody,
        )
      : _buildBody(context, bottom_sheet.ModalScrollController.of(context));

  Material _buildBody(
    BuildContext context,
    ScrollController? scrollController,
  ) {
    return Material(
      color: backgroundColor ?? context.surfaceContainer,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: removeTopPadding,
        child: Builder(
          builder: (context) => SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBarHandle(context),
                _buildChild(context, scrollController),
                _buildBottom(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarHandle(BuildContext context) {
    return barHandle ?? SmartBarHandle.slim(enabled: showBarHandle);
  }

  Widget _buildChild(BuildContext context, ScrollController? scrollController) {
    return Expanded(
      child: builder != null && scrollController != null
          ? builder!.call(context, scrollController)
          : child ?? const SizedBox(),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return bottom != null
        ? bottom!.expanded().row().paddingAll(16.0)
        : const SizedBox();
  }
}

/// A handle for the [SmartBottomSheet].
class SmartBarHandle extends StatelessWidget {
  const SmartBarHandle({
    this.color,
    this.enabled = true,
    this.opacity = 1.0,
    this.radius = 4.0,
    this.height = 0.0,
    this.barWidth = 52.0,
    this.thickness = 4.0,
    super.key,
  });

  const SmartBarHandle.slim({
    this.color,
    this.enabled = true,
    this.opacity = 0.2,
    this.radius = 4.0,
    this.height = 10.0,
    this.barWidth = 52.0,
    this.thickness = 4.0,
    super.key,
  });

  final Color? color;
  final bool enabled;
  final double opacity;
  final double radius;
  final double height;
  final double barWidth;
  final double thickness;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height),
            child: Container(
              height: thickness,
              width: barWidth,
              decoration: enabled
                  ? ShapeDecoration(
                      color: (color ?? context.hintColor).withOpacity(opacity),
                      shape: radius.roundedRectangleBorder(),
                    )
                  : null,
            ),
          ),
        ],
      );
}

/// Shows a modal Material Design bottom sheet.
Future<T?> showMaterialModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  ShapeBorder? shape,
  bool isScrollControlled = true,
  bool isDismissible = true,
}) =>
    showModalBottomSheet<T>(
      context: context,
      builder: builder,
      shape: shape ?? kSmartBottomSheetRoundedshape,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
    );

/// Shows a modal Cupertino style bottom sheet.
Future<T?> showCupertinoModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool expand = false,
}) =>
    bottom_sheet.CupertinoScaffold.showCupertinoModalBottomSheet<T>(
      context: context,
      builder: builder,
      isDismissible: isDismissible,
      expand: expand,
      backgroundColor: Colors.transparent,
    );

/// Shows a modal bottom sheet with a bar.
Future<T?> showBarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Widget? bar,
  ShapeBorder? shape,
  bool isDismissible = true,
  bool expand = false,
}) =>
    bottom_sheet.showBarModalBottomSheet<T>(
      context: context,
      builder: builder,
      topControl: bar,
      shape: shape ?? kSmartBottomSheetRoundedshape,
      isDismissible: isDismissible,
      expand: expand,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
    );
