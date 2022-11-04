part of 'widgets.dart';

const kRowTileLeadingMargin = EdgeInsets.zero;
const kRowTileLeadingPadding =
    EdgeInsetsDirectional.only(end: kStandardPaddingX);
const kRowTileLeadingDensePadding =
    EdgeInsetsDirectional.only(end: kDensePaddingX);
const kRowTileLeadingMediumPadding =
    EdgeInsetsDirectional.only(end: kMediumPaddingX);
const kRowTileTrailingPadding = EdgeInsetsDirectional.only(start: 6);
const kRowTileChildrenPadding = EdgeInsets.all(0.5);
const kRowTileConstraints = BoxConstraints(minHeight: 26.5);

const kRowTileTrailingSize = 20.0;
const kRowTileLeadingSmallSize = 20.0;
const kRowTileMaxLines = 2;
const kRowTileFontSize = 12.0;

class SmartRowTile extends StatelessWidget {
  /// Row with simple content
  const SmartRowTile.simple({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding,
    this.bottomPadding,
    this.startPadding,
    this.endPadding,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with simple content and cupertino tap effect
  const SmartRowTile.cupertino({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding,
    this.bottomPadding,
    this.startPadding,
    this.endPadding,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = true,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with simple content and dense paddings
  const SmartRowTile.dense({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = kDensePaddingY,
    this.bottomPadding = kDensePaddingY,
    this.startPadding = kDensePaddingX,
    this.endPadding = kDensePaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingDensePadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with simple content and medium paddings
  const SmartRowTile.medium({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = kMediumPaddingY,
    this.bottomPadding = kMediumPaddingY,
    this.startPadding = kMediumPaddingX,
    this.endPadding = kMediumPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingMediumPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with extended content
  const SmartRowTile.extend({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding,
    this.bottomPadding,
    this.startPadding,
    this.endPadding,
    this.expanded = true,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.start,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with grouped header content including top/bottom separators
  const SmartRowTile.header({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 28,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider = DividerStyle.full,
    this.bottomDivider = DividerStyle.full,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with grouped header dense content including top/bottom separators
  const SmartRowTile.headerDense({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 16,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider = DividerStyle.full,
    this.bottomDivider = DividerStyle.full,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with dense header content and without top separator to use at
  /// top of the views
  const SmartRowTile.headerTop({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 28,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider = DividerStyle.full,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with grouped header dense content including bottom separator only
  const SmartRowTile.headerTopDense({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 16,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider = DividerStyle.full,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with grouped header content without top/bottom separators
  const SmartRowTile.section({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 28,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with grouped header dense content without top/bottom separators
  const SmartRowTile.sectionDense({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 16,
    this.bottomPadding,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = true,
    this.header = true,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with wrapped layout and can be used in the buttons too
  const SmartRowTile.wrap({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize = kRowTileFontSize,
    this.leadingSize,
    this.leadingBoxSize = 24,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = false,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = false,
    this.wrap = true,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingDensePadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with rich content
  const SmartRowTile.rich({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize = kRowTileFontSize,
    this.leadingSize = kRowTileLeadingSmallSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.startPadding = kStandardPaddingX,
    this.endPadding = kStandardPaddingX,
    this.expanded = false,
    this.leadingFilled = true,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = true,
    this.themed = false,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kRowTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with simple content and layout as [GetTile.simple]
  const SmartRowTile.item({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = kStandardPaddingY,
    this.bottomPadding = kStandardPaddingY,
    this.startPadding,
    this.endPadding,
    this.expanded = true,
    this.leadingFilled = true,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = true,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kTileConstraints,
    this.alignment = CrossAxisAlignment.start,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  /// Row with simple content and layout as [GetTile.simple]
  const SmartRowTile.itemPad({
    this.leading,
    this.trailing,
    this.trailingText,
    this.trailingStyle,
    this.children,
    this.child,
    this.text,
    this.textStyle,
    this.hint,
    this.color,
    this.textColor,
    this.backgroundColor,
    this.trailingColor,
    this.maxLines = kRowTileMaxLines,
    this.fontWeight,
    this.fontSize,
    this.leadingSize,
    this.leadingBoxSize = SmartBox.kBoxSize,
    this.trailingSize = kRowTileTrailingSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.topPadding = kExtendedPaddingY,
    this.bottomPadding = kExtendedPaddingY,
    this.startPadding,
    this.endPadding,
    this.expanded = true,
    this.leadingFilled = true,
    this.leadingTinted = false,
    this.leadingSmall = true,
    this.leadingOval = false,
    this.themed = true,
    this.wrap = false,
    this.enabled = true,
    this.highlighted,
    this.checked,
    this.tintAble = false,
    this.destructive,
    this.detail = false,
    this.allCaps = false,
    this.header = false,
    this.cupertino = false,
    this.animate = false,
    this.topDivider,
    this.bottomDivider,
    this.padding,
    this.leadingMargin = kRowTileLeadingMargin,
    this.leadingPadding = kRowTileLeadingPadding,
    this.trailingPadding = kRowTileTrailingPadding,
    this.childrenPadding = kRowTileChildrenPadding,
    this.constraints = kTileConstraints,
    this.alignment = CrossAxisAlignment.center,
    this.onTap,
    this.onTapLeading,
    Key? key,
  }) : super(key: key);

  final dynamic leading;
  final Widget? trailing;
  final String? trailingText;
  final TextStyle? trailingStyle;
  final List<Widget>? children;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final String? hint;
  final Color? color;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? trailingColor;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? leadingSize;
  final double leadingBoxSize;
  final double? trailingSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? topPadding;
  final double? bottomPadding;
  final double? startPadding;
  final double? endPadding;
  final bool expanded;
  final bool leadingFilled;
  final bool leadingTinted;
  final bool leadingSmall;
  final bool leadingOval;
  final bool themed;
  final bool wrap;
  final bool enabled;
  final bool? highlighted;
  final bool? checked;
  final bool tintAble;
  final bool? destructive;
  final bool detail;
  final bool allCaps;
  final bool header;
  final bool cupertino;
  final bool animate;
  final DividerStyle? topDivider;
  final DividerStyle? bottomDivider;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry leadingMargin;
  final EdgeInsetsGeometry leadingPadding;
  final EdgeInsetsGeometry trailingPadding;
  final EdgeInsetsGeometry childrenPadding;
  final BoxConstraints? constraints;
  final CrossAxisAlignment alignment;
  final VoidCallback? onTap;
  final VoidCallback? onTapLeading;

  @override
  Widget build(BuildContext context) {
    final String? vText =
        (text ?? hint)?.applyIf(allCaps, (it) => it?.uppercase);
    final vColor = context.tileIconColor ?? context.secondaryColor;
    final vTintColor = destructive == true ? Colors.red : color ?? vColor;
    final vTintAble = destructive == true || tintAble;
    final vTrailingColor = trailingColor ??
        (detail
            ? context.hintColor
            : vTintAble
                ? vTintColor
                : context.iconColor ?? context.secondaryColor);
    final vTextColor = textColor ?? (vTintAble ? vTintColor : textStyle?.color);
    final vTextStyle = (textStyle ?? context.caption)
        ?.copyWith(fontWeight: fontWeight, color: vTextColor);
    final vConstrained = alignment == CrossAxisAlignment.start ||
        alignment == CrossAxisAlignment.end;
    final vTrailing = trailing ??
        (checked == true
            ? const Icon(CupertinoIcons.check_mark)
            : detail
                ? const Icon(CupertinoIcons.chevron_right)
                : null);
    final vShowTrailing = vTrailing != null || trailingText?.notEmpty != null;
    final vHighlighted = highlighted ?? checked ?? false;
    final vBackground = vHighlighted
        ? vTintColor.highlighted
        : backgroundColor ?? (themed ? context.backgroundColor : null);
    final vBoxedView = $cast<SmartBox>(leading);
    final isCustomLeading = leading is! Icon &&
        leading is! SmartBox &&
        leading is! Text &&
        leading is Widget;
    return vText?.notEmpty == null &&
            child == null &&
            children?.isNotEmpty != true
        ? 0.space
        : CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: enabled && cupertino ? onTap : null,
            child: InkWell(
              highlightColor: vTintColor.highlighted,
              splashColor: vTintColor.lighted,
              onTap: enabled && !cupertino ? onTap : null,
              child: Ink(
                color: vBackground,
                padding: padding ??
                    EdgeInsetsDirectional.only(
                      start: horizontalPadding ??
                          startPadding ??
                          kStandardPaddingX,
                      end: horizontalPadding ?? endPadding ?? kStandardPaddingX,
                      top: verticalPadding ?? topPadding ?? kDensePaddingY,
                      bottom:
                          verticalPadding ?? bottomPadding ?? kDensePaddingY,
                    ),
                child: Row(
                  mainAxisSize: wrap ? MainAxisSize.min : MainAxisSize.max,
                  crossAxisAlignment: alignment,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    SmartCrossFade(
                      animate: animate,
                      showFirst: leading != null,
                      firstChild: leading != null
                          ? Container(
                              constraints: vConstrained ? constraints : null,
                              alignment: Alignment.center,
                              padding: leadingMargin,
                              child: isCustomLeading
                                  ? leading
                                  : vBoxedView?.custom == true
                                      ? vBoxedView!
                                      : SmartBox(
                                          child: vBoxedView?.child ?? leading!,
                                          color:
                                              vBoxedView?.color ?? vTintColor,
                                          filled: vBoxedView?.filled ??
                                              leadingFilled,
                                          tinted: vBoxedView?.tinted ??
                                              leadingTinted,
                                          margin: vBoxedView?.margin ??
                                              leadingPadding,
                                          small:
                                              vBoxedView?.small ?? leadingSmall,
                                          wrap: vBoxedView?.wrap ?? false,
                                          safeBorder:
                                              vBoxedView?.safeBorder ?? false,
                                          boxSize: vBoxedView?.boxSize ??
                                              leadingBoxSize,
                                          fontSize: vBoxedView?.fontSize,
                                          iconSize: vBoxedView?.iconSize ??
                                              leadingSize,
                                          oval: vBoxedView?.oval ?? leadingOval,
                                          onTap:
                                              vBoxedView?.onTap ?? onTapLeading,
                                        ),
                            )
                          : null,
                    ),
                    Container(
                      constraints: vConstrained ? constraints : null,
                      alignment: context.isRTL
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: child ??
                          (children?.isNotEmpty == true
                              ? RichText(
                                  text: TextSpan(
                                    style: vTextStyle?.copyWith(
                                      color: text == null
                                          ? context.hintColor
                                          : null,
                                      fontSize: fontSize,
                                    ),
                                    children: [
                                      TextSpan(text: vText),
                                      ...?children?.map((w) =>
                                          $cast<Text>(w)?.mapTo(
                                            (Text w) => TextSpan(
                                              text: w.data,
                                              style: (w.style ?? vTextStyle)
                                                  ?.copyWith(
                                                fontSize: fontSize,
                                              ),
                                            ),
                                          ) ??
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Padding(
                                              padding: childrenPadding,
                                              child: w,
                                            ),
                                          ))
                                    ].applyIf(context.isRTL,
                                        (it) => it?.reversed.toList()),
                                  ),
                                  maxLines: expanded ? null : maxLines,
                                  overflow: expanded || maxLines == null
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                )
                              : Text(
                                  vText ?? '',
                                  style: vTextStyle?.copyWith(
                                    color:
                                        text == null ? context.hintColor : null,
                                    fontSize: fontSize,
                                  ),
                                )),
                    ).flex(enabled: !wrap, expanded: true),
                    if (vShowTrailing)
                      Container(
                        constraints: vConstrained ? constraints : null,
                        alignment: Alignment.center,
                        padding: detail
                            ? const EdgeInsetsDirectional.only(start: 2)
                            : trailingPadding,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: vTrailing is Icon ? 1 : 0,
                          ),
                          child: IconTheme(
                            data: IconThemeData(
                              color: vTrailingColor,
                              size: detail ? 14 : trailingSize,
                            ),
                            child: trailingText?.notEmpty?.mapIt((it) => Text(
                                      it,
                                      style: trailingStyle ?? context.caption,
                                    )) ??
                                vTrailing ??
                                0.space,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ).column(
              // enabled: header,
              crossAxisAlignment: header
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.start,
              before: [
                if (topDivider != null) SmartTileDivider(style: topDivider!),
              ],
              after: [
                if (bottomDivider != null)
                  SmartTileDivider(style: bottomDivider!),
              ],
            ),
          );
  }
}

enum DividerStyle {
  /// full divider with no indentation
  full,

  /// divider with indent equals to the size of the leading widget and padding
  leading,

  /// divider with indent equals to the leading padding only
  noLeading,

  /// no divider at all
  none,
}

class SmartTileDivider extends StatelessWidget {
  const SmartTileDivider({
    this.indent,
    this.thickness = 0.5,
    this.color,
    this.style = DividerStyle.leading,
    Key? key,
  }) : super(key: key);

  /// Tile divider with full edge to edge length
  const SmartTileDivider.full({Key? key})
      : this(style: DividerStyle.full, key: key);

  /// Tile divider with [kStandardPaddingX] padding at start
  const SmartTileDivider.notLeading({Key? key})
      : this(style: DividerStyle.noLeading, key: key);

  /// Tile divider with `[kStandardPaddingX.twice + BoxedView.kBoxSize]`
  /// padding at start
  const SmartTileDivider.leading({Key? key})
      : this(style: DividerStyle.leading, key: key);

  final double? indent;
  final double thickness;
  final Color? color;
  final DividerStyle style;

  @override
  Widget build(BuildContext context) => style == DividerStyle.none
      ? const Space()
      : Ink(
          color: context.backgroundColor,
          child: SmartDivider(
            indent: indent,
            thickness: thickness,
            color: color,
            style: style,
          ),
        );
}

class SmartDivider extends StatelessWidget {
  const SmartDivider({
    this.indent,
    this.thickness = 0.5,
    this.color,
    this.style = DividerStyle.full,
    Key? key,
  }) : super(key: key);

  /// Divider with full edge to edge length
  const SmartDivider.full({Key? key})
      : this(style: DividerStyle.full, key: key);

  /// Divider with [kStandardPaddingX] padding at start
  const SmartDivider.notLeading({Key? key})
      : this(style: DividerStyle.noLeading, key: key);

  /// Divider with `[kStandardPaddingX.twice + BoxedView.kBoxSize]`
  /// padding at start
  const SmartDivider.leading({Key? key})
      : this(style: DividerStyle.leading, key: key);

  final double? indent;
  final double thickness;
  final Color? color;
  final DividerStyle style;

  @override
  Widget build(BuildContext context) => style == DividerStyle.none
      ? const Space()
      : Container(
          margin: EdgeInsetsDirectional.only(
            start: indent ??
                (style == DividerStyle.full
                    ? 0
                    : style == DividerStyle.noLeading
                        ? kStandardPaddingX
                        : kStandardPaddingX.twice + SmartBox.kBoxSize),
          ),
          color: color ?? context.hintColor.subbed,
          height: thickness,
        );
}

class SmartSectionTile extends StatelessWidget {
  const SmartSectionTile({
    this.title,
    this.titleChildren,
    this.titleStyle,
    this.backgroundColor,
    this.color,
    this.leading,
    this.trailing,
    this.accessory,
    this.borderRadius,
    this.leadingSize = 16,
    this.margin,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.leadingPadding = const EdgeInsetsDirectional.only(end: 8),
    this.onTap,
    super.key,
  });

  final String? title;
  final List<Widget>? titleChildren;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? color;
  final dynamic leading;
  final Widget? trailing;
  final Widget? accessory;
  final double? borderRadius;
  final double leadingSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry leadingPadding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SmartListTile.custom(
      backgroundColor: backgroundColor ?? Colors.transparent,
      margin: margin,
      padding: padding,
      title: title,
      titleChildren: titleChildren,
      titleStyle: titleStyle ?? context.appBarTheme.titleTextStyle,
      leading: leading,
      trailingTopChild: trailing,
      accessory: accessory,
      onTap: onTap,
      borderRadius: borderRadius,
      leadingBoxSize: leadingSize,
      leadingSize: leadingSize,
      leadingPadding: leadingPadding,
      trailingColor: color,
      color: color,
      cupertino: true,
      tintAccessory: true,
      alignment: CrossAxisAlignment.center,
    );
  }
}
