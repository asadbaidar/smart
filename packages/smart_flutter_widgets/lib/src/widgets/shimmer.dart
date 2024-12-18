import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

extension ShimmerWidget on Widget {
  Widget shimmer({
    Key? key,
    Color? baseColor,
    Color? highlightColor,
    Duration period = const Duration(milliseconds: 900),
    ShimmerDirection direction = ShimmerDirection.ltr,
    int loop = 0,
    bool filled = false,
    bool enabled = true,
  }) {
    return enabled
        ? Builder(
            builder: (context) => Shimmer.fromColors(
              key: key,
              baseColor: baseColor ?? context.surfaceContainer,
              highlightColor:
                  highlightColor ?? context.surfaceContainer.highlighted,
              period: period,
              direction: direction,
              loop: loop,
              child: filled
                  ? ColoredBox(
                      color: Colors.grey,
                      child: this,
                    )
                  : this,
            ),
          )
        : this;
  }
}
