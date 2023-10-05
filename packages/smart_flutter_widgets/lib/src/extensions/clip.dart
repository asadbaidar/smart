part of 'extensions.dart';

extension ClipWidget on Widget {
  Widget clipOval({
    Key? key,
    bool clip = true,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      clip
          ? ClipOval(
              key: key,
              clipper: clipper,
              clipBehavior: clipBehavior,
              child: this,
            )
          : this;

  Widget clipRect({
    Key? key,
    bool clip = true,
    bool oval = false,
    BorderRadius borderRadius = BorderRadius.zero,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      clip
          ? oval
              ? ClipOval(
                  key: key,
                  clipBehavior: clipBehavior,
                  child: this,
                )
              : ClipRRect(
                  key: key,
                  borderRadius: borderRadius,
                  clipBehavior: clipBehavior,
                  child: this,
                )
          : this;
}
