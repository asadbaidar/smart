part of 'widgets.dart';

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
              baseColor: baseColor ?? context.backgroundColor,
              highlightColor:
                  highlightColor ?? context.backgroundColor.highlighted,
              period: period,
              direction: direction,
              loop: loop,
              child: filled
                  ? Container(
                      color: Colors.grey,
                      child: this,
                    )
                  : this,
            ),
          )
        : this;
  }
}
