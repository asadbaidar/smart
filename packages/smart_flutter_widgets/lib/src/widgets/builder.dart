part of 'widgets.dart';

/// A stateless utility widget whose [build] method uses its
/// [builder] callback to create the widget's child and apply the [theme] on
/// descendant widgets if provided.
class SmartBuilder extends StatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  const SmartBuilder(
    this.builder, {
    super.key,
  }) : theme = null;

  /// Creates a widget that delegates its build to a callback and apply the
  /// [theme] on descendant widgets
  const SmartBuilder.theme(
    this.theme, {
    required this.builder,
    super.key,
  });

  /// Called to obtain the child widget.
  final WidgetBuilder builder;

  /// Specifies the color and typography values for descendant widgets.
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) => theme != null
      ? AnimatedTheme(
          data: theme!,
          child: Builder(builder: builder),
        )
      : builder(context);
}
