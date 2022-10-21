part of 'widgets.dart';

/// [SizedBox] clear implimentation for adding fixed spaces.
class Space extends StatelessWidget {
  const Space({
    this.x,
    this.y,
    super.key,
  });

  const Space.x(
    this.x, {
    super.key,
  }) : y = null;

  const Space.y(
    this.y, {
    super.key,
  }) : x = null;

  const Space.all(
    double? s, {
    super.key,
  })  : x = s,
        y = s;

  final double? x;
  final double? y;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: x,
        height: y,
      );
}
