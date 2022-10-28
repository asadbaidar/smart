part of 'widgets.dart';

const kSmartBottomSheetInitialSize = 0.5;
const kSmartBottomSheetMaxSize = 0.93;
const kSmartBottomSheetMinSize = 0.4;

const ShapeBorder kSmartBottomSheetRoundedshape = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(12),
  ),
);

typedef SmartCupertinoScafold = bottom_sheet.CupertinoScaffold;

class SmartBottomSheet<T> extends StatelessWidget {
  const SmartBottomSheet({
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
    super.key,
  }) : builder = null;

  const SmartBottomSheet.scrollable({
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
    super.key,
  }) : child = null;

  SmartBottomSheet.list({
    required SmartItemBuilder<T> itemBuilder,
    List<T>? items,
    int? itemCount,
    SmartSliverBuilder? topBuilder,
    SmartSliverBuilder? bottomBuilder,
    WidgetBuilder? headerBuilder,
    WidgetBuilder? footerBuilder,
    SmartSectionBuilder? sectionBuilder,
    SmartSection? section,
    IndexedWidgetBuilder? dividerBuilder,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
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
    super.key,
  })  : child = null,
        builder = ((context, scrollController) => SmartListView<T>.builder(
              controller: scrollController,
              itemBuilder: itemBuilder,
              items: items,
              itemCount: itemCount,
              topSliverBuilder: topBuilder,
              bottomSliverBuilder: bottomBuilder,
              headerBuilder: headerBuilder,
              footerBuilder: footerBuilder,
              sectionBuilder: sectionBuilder,
              section: section,
              dividerBuilder: dividerBuilder,
              padding: padding,
              removeTopPadding: true,
              physics: physics,
            ));

  SmartBottomSheet.sliver({
    required SmartSliverBuilder builder,
    SmartSliverBuilder? topBuilder,
    SmartSliverBuilder? bottomBuilder,
    ScrollPhysics? physics = const AlwaysBouncingScrollPhysics(),
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
    super.key,
  })  : child = null,
        builder = ((context, scrollController) => SmartListView<T>(
              controller: scrollController,
              sliverBuilder: builder,
              topSliverBuilder: topBuilder,
              bottomSliverBuilder: bottomBuilder,
              physics: physics,
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
      color: backgroundColor ?? context.backgroundColor,
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
