import 'package:flutter/material.dart';

extension MultiChildWidget on Widget {
  Widget stack({
    Key? key,
    bool enabled = true,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
    List<Widget> back = const [],
    List<Widget> front = const [],
  }) =>
      enabled
          ? Stack(
              key: key,
              alignment: alignment,
              fit: fit,
              clipBehavior: clipBehavior,
              children: [...back, this, ...front],
            )
          : this;

  Widget row({
    Key? key,
    bool enabled = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> before = const [],
    List<Widget> after = const [],
  }) =>
      enabled
          ? Row(
              key: key,
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              textBaseline: textBaseline,
              children: [...before, this, ...after],
            )
          : this;

  Widget column({
    Key? key,
    bool enabled = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> before = const [],
    List<Widget> after = const [],
  }) =>
      enabled
          ? Column(
              key: key,
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              textBaseline: textBaseline,
              children: [...before, this, ...after],
            )
          : this;
}
